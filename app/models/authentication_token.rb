class AuthenticationToken < ActiveRecord::Base
  ##callbacks
  before_create :generate_token

  ##associations
  belongs_to :user

  private
  def generate_token
    token = SecureRandom.hex
    while AuthenticationToken.where({auth_token: token}).present?
      # if generated random number already exist in database
      token = SecureRandom.hex
    end
    self.auth_token = token
  end
end
