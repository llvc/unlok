class Api::V1::PasswordsController < Api::V1::ApiController
  before_action :define_current_user, only: [:update]


  ##change_password => /api/change_password => :method => post
  # def update
  #   if params['user'][:current_password].present? && params['user'][:password].present?
  #     p params['user'][:current_password] == params['user'][:password]
  #     unless params['user'][:current_password] == params['user'][:password]
  #       if @user.update_with_password(change_password_params)
  #         render_json({:msg => "Your Password Successfully updated", :success => true, :blocked=>!@user.enable}.to_json)
  #       else
  #         render_json({:msg => @user.display_errors, :success => false}.to_json)
  #       end
  #     else
  #       render_json({:msg => "New Password can't be same as Old password.", :success => false, :blocked=>!@user.enable}.to_json)
  #     end
  #   else
  #     render_json({:msg => "Current Password and Password required", :success => false, :blocked=>!@user.enable}.to_json)
  #   end
  # end
  
  def new
    @user = User.find_by_email(params[:email])
    if @user.present?
      @user = User.send_reset_password_instructions(@user)
      render :json => { 
        :success => true,
        :msg => "Email has been sent successfully...Please check your email account...",
      }
    else
      render :json => { 
        :success => false,
        :msg => "You don't have account with this email...",
      }
    end
     
  end

  private
  def change_password_params
    params.require('user').permit(:current_password,:password,:password_confirmation)
  end
end
