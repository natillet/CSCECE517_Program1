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

  def get_posted_by_name(post)
    User.find_by_id(post.user_id).name
  end
end
