class Book < ActiveRecord::Base
  attr_accessible :author, :category, :isbn, :publisher, :returned, :title, :cover_url, :description
  attr_accessor :data

  default_scope order('title')

  has_many :checkouts, :dependent => :destroy
end
