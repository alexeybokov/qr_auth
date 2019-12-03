class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: true

  def generate_token
    begin
      self.token = ROTP::Base32.random
    end while self.class.exists?(token: token)
  end

  def qr_code
    _qrcode = RQRCode::QRCode.new(totp)
  end

  def totp
    totp = ROTP::TOTP.new(self.token, issuer: "My service")
    result = totp.provisioning_uri('localhost:3000')

    return result
  end
end
