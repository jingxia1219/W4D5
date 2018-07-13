# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  validates :username, :email, :password_digest, :session_token, presence: true
  validates :username, :email, :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  after_initialize :ensure_session_token
  
  attr_reader :password
  
  def password=(password)
    @password = password 
    self.password_digest = BCrypt::Password.create(password)
  end 
  
  def is_password?(password)
    BCrypt::Passowrd.new(password_digest).is_password?(password)
  end 
  
  private 
  
  def self.generate_session_token 
    SercureRandom.urlsafe_base64(16)
  end 
  
  def ensure_session_token
    self.session_token ||= User.generate_session_token 
  end
  
end
