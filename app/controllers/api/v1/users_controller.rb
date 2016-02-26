  class Api::V1::UsersController < Api::V1::ApiController
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]
  before_action :define_current_user, only: [:update_email,:update,:verify_scanned_qr,:change_notification_status,:otp_verification_after_edit,:enable_as_customer,:mail_of_qr_pdf]
  before_filter :login_required, :except=>[:new, :create]
  
  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    if params['user'][:email].present?
      @user = User.new(users_params)
      if @user.save
        @token = @user.authentication_tokens.build
        @token.save
      else
        render_json({:msg => @user.display_errors, :success => false}.to_json)
      end
    else
      # email blank
      render_json({:msg => "Email is required.",:success => false}.to_json)
    end
  end

  def signup_with_facebook_and_google
    # params['user'] = ActiveSupport::JSON.decode(params['user']).symbolize_keys!
    @user = User.find_by_email(params['user'][:email])
    if @user.nil?
      params['user'][:password] = rand(9999999999999)
      params['user'][:password_confirmation] = params['user'][:password]
      @user = User.new(users_params)
      if @user.save
        @token = @user.authentication_tokens.build
        @token.save
        render :file => 'api/v1/users/create'
        return
      else
        render_json({:msg => @user.display_errors, :success => false}.to_json)
      end
    else
      render :status => 200,
        :json => { 
              :success => false,
              :msg => "This email is already registered..."}                    
        return
    end
  end
  
  
  private
  def users_params
    params.require('user').permit(:email,:username,:password,:password_confirmation,:mobile_number,:facebook_token,:g_token, :device_token,:device_type)
  end
  def update_users_params
    params.require('user').permit(:username,:mobile_number)
  end
end





# 1701: Success, Message Submitted Successfully, In this case you will receive the response 1701|<CELL_NO>:<MESSAGE ID>, The message Id can then be used later to map the delivery reports to this message.
# 1702: Invalid URL Error, This means that one of the parameters was not provided or left blank
# 1703: Invalid value in username or password field
# 1704: Invalid value in "type" field
# 1705: Invalid Message
# 1706: Invalid Destination
# 1707: Invalid Source (Sender)
# 1708: Invalid value for "dlr" field
# 1709: User validation failed
# 1710: Internal Error
# 1025: Insufficient Credit
