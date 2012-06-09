class Post < ActiveRecord::Base
  attr_accessible :post
  has_many :comments, :dependent => :destroy
end
