class User < ActiveRecord::Base
  attr_accessible :is_admin, :name, :password_digest
  validates :name, :uniqueness => true, :presence => true
  has_many :posts
  has_many :comments
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

end
