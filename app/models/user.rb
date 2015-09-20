require 'bcrypt'

class User < ActiveRecord::Base
  has_many :questions
  has_many :answers, class_name: "Comment"

  include BCrypt

  validates :email, presence: true, uniqueness: true
  validates :password_hash, presence: true


  def username
    self.email.split("@").first
  end

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
