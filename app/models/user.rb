class User < ActiveRecord::Base
  default_scope { order('created_at DESC') } 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable,
          :omniauthable         
  
  has_many :authentication_tokens, :dependent => :destroy
  has_one :picture, :as => :imageable, :dependent => :destroy
  has_many :bookings, :as => :bookable, :dependent => :destroy
  has_one :shopping_cart, :class_name => 'ShoppingCart', :foreign_key => 'user_id'
  has_many :orders, through: :shopping_cart
  has_many :my_orders, class_name: "Order"

  has_one :profile
  # validates :username, presence: true
  # validates_uniqueness_of :username, :message => "has been already taken."
  # validates_email_realness_of :email
  validates_format_of :mobile_number, :with => /\A91\d{10}\z/, :message => "is invalid,it should be 91 + 10 digit number", :if => :mobile_number?
  
  


   def self.from_omniauth(auth)
    user = User.find_by(email: auth.info.try(:email))
    return user if user

    User.where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      p user.email = auth.info.email
      p user.password = Devise.friendly_token[0,20]
      UserMailer.welcome_email(user).deliver_now
      #user.name = auth.info.name   # assuming the user model has a name
      #user.image = auth.info.image # assuming the user model has an image
      return user
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:provider => access_token.provider, :uid => access_token.uid ).first
    if user
      return user
    else
      registered_user = User.where(:email => access_token.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(provider:access_token.provider,
            email: data["email"],
            uid: access_token.uid ,
            password: Devise.friendly_token[0,20],
        )
        UserMailer.welcome_email(user).deliver_now
        return user
      end
    end
  end

  class << self
    # def authenticate_user_with_auth_token(user_name,password)
    #   return nil unless user_name.present? or password.present?
    #   u = User.find_by(user_name: user_name) rescue nil
    #   # check for user existence
    #   (u.present? && u.valid_password?(password)) ? u : nil
    # end  
    def authenticate_user_email_with_auth_token(email,password)
      return nil unless email.present?  or password.present?
      if email.present?
        u = User.find_by(email: email) rescue nil
      end
      # if u.nil?
      #   u = User.find_by(username: email) rescue nil
      # end
      (u.present? && u.valid_password?(password)) ? u : nil
    end  
  end

  # errors
  def display_errors
    p self.errors
    self.errors.full_messages.join(', ')
  end
end
