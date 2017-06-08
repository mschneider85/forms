class User < ApplicationRecord
  has_many :campaigns_users
  has_many :campaigns, through: :campaigns_users

  TOKEN_VALIDITY = 15
  @email_regexp = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/

  enum role: { member: 0, admin: 1 }

  validates :email, presence: true
  validates :email, uniqueness: true, format: { with: @email_regexp }, if: :email_changed?

  def self.find_by_token(token)
    where(login_token: token).where('token_generated_at > ?', TOKEN_VALIDITY.minutes.ago).take
  end

  def anonymous?
    false
  end

  def set_login_token!
    update(login_token: SecureRandom.urlsafe_base64, token_generated_at: Time.current)
  end

  def nullify_login_token!
    update!(login_token: nil, token_generated_at: Time.current)
  end
end
