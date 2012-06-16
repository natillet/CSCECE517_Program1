class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  attr_accessible :comment

  def self.search(search)
    if search
      find(:all, :conditions => ['comment LIKE ?', "%#{search}%"])
    else
      #find(:all)
    end
  end
end
