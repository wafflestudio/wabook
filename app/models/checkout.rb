class Checkout < ActiveRecord::Base
  attr_accessible :book_id, :user_id, :checkoutdate, :duedate, :returned
  belongs_to :user
  belongs_to :book
end
