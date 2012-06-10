class Post < ActiveRecord::Base
  attr_accessible :post
  has_many :comments, :dependent => :destroy
  belongs_to :user

  def self.search(search)
    if search
      find(:all, :conditions => ['post LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end
end