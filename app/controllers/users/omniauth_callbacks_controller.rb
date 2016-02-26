class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    isFirst = false
    isFirst = true if User.where(email: request.env["omniauth.auth"].info.try(:email)).first.nil?
    @user = User.from_omniauth(request.env["omniauth.auth"])

    puts "--------------------------------------------"
    puts request.env["omniauth.auth"].inspect
    puts "---------------------------------------------"
    if @user
      @user.facebook_token = @user.uid
      @user.save

      # UserMailer.welcome_email(@user).deliver_now unless @user.invalid?

      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def google_oauth2
    isFirst = false
    isFirst = true if User.where(email: request.env["omniauth.auth"].info.try(:email)).first.nil?
    @user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)

    puts "--------------------------------------------"
    puts request.env["omniauth.auth"].inspect
    puts "---------------------------------------------"
    if @user.persisted?
      @user.g_token = @user.uid
      @user.save

      # UserMailer.welcome_email(@user).deliver_now unless @user.invalid?

      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.google_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end