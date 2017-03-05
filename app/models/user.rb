class User < ApplicationRecord
  VALID = 15

  def self.find_by_token(token)
    where(login_token: token).where('token_generated_at > ?', VALID.minutes.ago).take
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
