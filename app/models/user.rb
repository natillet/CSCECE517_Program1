

class User < ActiveRecord::Base
after_destroy :ensure_an_admin_remains

  attr_accessible :is_admin, :name, :password_digest
  validates :name, :uniqueness => true, :presence => true
  has_many :posts, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  before_save :encrypt_password

  public
  def match_password(submitted_password)
    password_digest == encrypt(submitted_password)
  end

  def authenticate(username, submitted_password)
    user = User.find_by_name(username)
    return nil  if user.nil?
    return user if user.match_password(submitted_password)
  end

  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      #find(:all)
    end
  end

  def get_number_of_posts
    Post.where(:user_id => id).count
  end
  def get_number_of_comments
    Comment.where(:user_id => id).count
  end

  private

  def encrypt_password
    self.password_digest = encrypt(password_digest)
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end

  def encrypt(string)
    secure_hash(string)
  end

   def ensure_an_admin_remains

      if User.where(:is_admin => true).count.zero?

       raise "Cannot delete last remaining administrator"


     end
   end

end
