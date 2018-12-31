require 'rails_helper'

RSpec.describe "" do

end

# As a merchant
# When I visit my dashboard, I see an area with statistics:
# - top 5 items I have sold by quantity
# - total quantity of items I've sold, and as a percentage against my sold units plus remaining inventory (eg, if I have sold 1,000 things and still have 9,000 things in inventory, the message would say something like "Sold 1,000 items, which is 10% of your total inventory")
# - top 3 states where my items were shipped
# - top 3 city/state where my items were shipped (Springfield, MI should not be grouped with Springfield, CO)
# - name of the user with the most orders from me (pick one if there's a tie)
# - name of the user who bought the most total items from me (pick one if there's a tie)
# - top 3 users who have spent the most money on my items
