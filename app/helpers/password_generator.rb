require 'securerandom'

module PasswordGenerator
  PASSWORD_LENGTH = 8

  def self.generate
    SecureRandom.urlsafe_base64(8)[0..PASSWORD_LENGTH-1]
  end
end