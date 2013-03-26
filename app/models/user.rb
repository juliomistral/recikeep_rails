require 'password_policy'

class User < ActiveRecord::Base
  attr_accessible :username, :email, :password, :password_confirmation, :first_name, :last_name

  attr_accessor :password
  before_save :prepare_password

  validates_presence_of :email
  validates_uniqueness_of :email
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i

  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
  validates_length_of :password, :minimum => 4, :allow_blank => true

  has_many :recipes
  has_many :tags

  def self.authenticate_login(login, pass)
    user = find_by_email(login)
    return user if user && PasswordPolicy.passwords_match?(user, pass)
  end

  def greeting
    self.first_name != nil ? self.first_name : self.email
  end

  private

  def prepare_password
    PasswordPolicy.secure_user(self, password)
  end
end
