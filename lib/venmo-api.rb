require 'json'
require 'payment'
require 'user'
enable :sessions

VENMO_CLIENT_ID             = '1336'
VENMO_CLIENT_SECRET         = 'r8YH6sz3ySSNLtkPQG4kV9u9nvnvksPY'
VENMO_BASE_URL              = 'https://api.venmo.com/'
VENMO_DEFAULT_SCOPES        = [	'access_profile',
                                'access_friends',
                                'access_feed',
                                'make_payments']


def redirect_to_venmo_auth_url
	redirect VENMO_BASE_URL \
          + "oauth/authorize?client_id=" + VENMO_CLIENT_ID \
          + "&scope=" + VENMO_DEFAULT_SCOPES.join(',') \
          + "&response_type=code"
end


def access_token_for_code(auth_code)
  buffer = ""
  access_token_exchange_url = "#{VENMO_BASE_URL}oauth/access_token"
  uri = URI.parse(access_token_exchange_url)
  response = Net::HTTP.post_form(uri, { "code" => auth_code, 
                                        "client_id" => "#{VENMO_CLIENT_ID}", 
                                        "client_secret" => "#{VENMO_CLIENT_SECRET}"})
    
  body = response.body
  if Integer(response.code) < 400
  	body_hash = JSON.load body
  	return body_hash["access_token"]
  else
  	return ""
  end
end


def process_payment(payment)
  payment_url = "#{VENMO_BASE_URL}payments"
  uri = URI.parse(payment_url)

  response = Net::HTTP.post_form(uri, { "access_token" => session["venmo_access_token"],
                                        "user_id" => payment.to,
                                        "amount" => payment.amount,
                                        "note" => payment.note})

  if Integer(response.code) < 400
  	body = response.body
  	body_hash = JSON.load body
  	if body_hash["status"] == "PAYMENT_SETTLED"
  		payment.instance_variable_set(:@status, 2)
  		return true
  	end
  end

  payment.instance_variable_set(:@status_message, response.message)
  payment.instance_variable_set(:@status, -1)
  return false
end
