class ProfilesController < ApplicationController
    before_action :set_items

  def edit
    if current_user.profile.nil?
      current_user.build_profile
      current_user.profile.save
    end
  end

  def save

    if current_user.update(user_params) && current_user.profile.update(profile_params)
      @status = 'success'
      render :edit
    else
      @status = 'fail'
      @errors = current_user.errors
      if @errors.nil? or @errors.blank?
        @errors = current_user.profile.errors
      end
      render :edit
    end
  end

  private
   def set_items
       @items = Item.all 
    end

  def profile_params
    params.require(:profile).permit(:name, :gender, :location, :shipping_address, :billing_address, :avatar)
  end

  def user_params
    params.require(:user).permit(:email, :mobile_number)
  end
end