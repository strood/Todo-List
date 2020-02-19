class Item
  attr_reader :title, :deadline, :description, :done
  attr_writer :title, :description

  def initialize(title, deadline, description)
    @title = title
    if !Item.valid_date?(deadline)
      raise "Not a valid date"
    end
    @deadline = deadline
    @description = description
    @done = false
  end

  def deadline=(new_deadline)
    if !Item.valid_date?(new_deadline)
      raise "Not a valid date"
    end
    @deadline = new_deadline
  end

  def toggle
    if @done
      @done = false
    else
      @done = true
    end
  end

  #accept a string and return a boolean indicating if it is valid date of the form
  # YYYY-MM-DD where Y, M, and D are numbers, such as 1912-06-23
  # done as class method as it needs no knowledge of specific item
  def self.valid_date?(date_string)
    ymd = date_string.split("-")
    return true if ymd[0].to_i > 1000 && ymd[0].to_i < 3000 && ymd[1].to_i > 0 && ymd[1].to_i < 13 && ymd[2].to_i > 0 && ymd[2].to_i < 32
    false
  end
end

#Tester code below

# p Item.valid_date?("2019-10-25") # true
# p Item.valid_date?("1912-06-23") # true
# p Item.valid_date?("2018-13-20") # false
# p Item.valid_date?("2018-12-32") # false
# p Item.valid_date?("10-25-2019") # false

# p Item.new("Fix login page", "2019-10-25", "The page loads too slow.")

# p Item.new(
#   "Buy Cheese",
#   "2019-10-21",
#   "We require American, Swiss, Feta, and Mozzarella cheese for the Happy hour!"
# )

# # Item.new(
# #   "Fix checkout page",
# #   "10-25-2019",
# #   "The font is too small."
# # ) # raises error due to invalid date
