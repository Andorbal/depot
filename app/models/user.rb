class User < ActiveRecord::Base
  attr_accessible :name, :password, :password_confirmation
  validates :name, presence: true,
                   uniqueness: true
  has_secure_password
  after_destroy :ensure_an_admin_remains

  private

  def ensure_an_admin_remains
    raise "Can't delete last user" if User.count.zero?
  end
end
