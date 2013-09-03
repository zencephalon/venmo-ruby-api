class Payment

@from = ""
@to = ""
@amount = 0
@note =""

# statusses
# unsent = 0
# sent - no status = 1
# complete = 2
# failed = -1
attr_accessor :status
@status = 0

attr_accessor :status_message
@status_message = ""


# from & to are strings
# amount is a double of the dollar-value
# request a payment by sending a negative amount
 def initialize(to, note, amount, from = "", status = 0, status_message = "")
	@to = to
	@amount = amount
	@note = note

	@from = from
	
	@status = status
	@status_message = status_message
end

def from
  @from
end

def to
  @to
end

def amount
  @amount
end

def note
  @note
end

def status
  @status
end

def status_message
  @status_message
end

end