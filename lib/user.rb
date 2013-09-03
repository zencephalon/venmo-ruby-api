class User

  @venmo_id = -1
  @first_name = ""
  @last_name = ""
  @email = ""
  @phone = ""

  def initialize (venmo_id, first_name="", last_name="", email="", phone="")
    @venmo_id = venmo_id
    @first_name = first_name
    @last_name = last_name
    @email = email
    @phone = phone
  end

  def self.user_with_id(venmo_id)

  end


  def self.my_friends
    if session["venmo_access_token"]

    end
  end

end