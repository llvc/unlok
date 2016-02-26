class Api::V1::SessionsController < Api::V1::ApiController

  before_action :define_current_user, only: [:destroy]

  def create
    # @valid_user_name = params[:user_name].present?
    @valid_email = params[:email].present?
    @valid_password = params[:password].present?
    if params[:facebook_token].present?
      @user=User.find_by(facebook_token: params[:facebook_token])
      unless @user.present?
        render_json({:msg => "Facebook token does not exist",:success => false, :is_registered=>false}.to_json)
        return
      end
      params[:login_for]="customer"
    elsif params[:g_token].present?
      @user=User.find_by(g_token: params[:g_token])
      unless @user.present?
        render_json({:msg => "Twitter token does not exist",:success => false, :is_registered=>false}.to_json)
        return
      end
      params[:login_for]="customer"
    else
      params[:email] = params[:email].downcase
      @user = User.authenticate_user_email_with_auth_token(params[:email],params[:password])
    end   
    if @user.present?
      # generate token for new session
      @token = @user.authentication_tokens.build
      @token.save
      @user.update_attributes(:device_token=>params[:device_token],:device_type=>params[:device_type])
    elsif !@valid_password && !@valid_email 
      # email and password both are blank
      render_json({:msg => "Email or User name and Password is required",:success => false}.to_json)
    elsif !@valid_email 
      # email blank
      render_json({:msg => "Email or User name is required",:success => false}.to_json)
    elsif !@valid_password
      # password blank
      render_json({:msg => "Password is required",:success => false}.to_json)
    else
      # both present but invalid
      render_json({:msg => "Invalid credentials",:success => false}.to_json)
    end
  end

  def destroy
    @token.destroy
    render_json({:msg => "Logout Successfully!", :success=>true}.to_json)
  end

end
