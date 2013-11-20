class Book < ActiveRecord::Base
  attr_accessible :author, :category, :isbn, :publisher, :returned, :title
  attr_accessor :data

  default_scope order('title')

  has_many :checkouts
end
