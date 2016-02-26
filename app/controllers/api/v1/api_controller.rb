class Api::V1::ApiController < ApplicationController
  rescue_from ActionController::RoutingError,:with => :no_route_found
  rescue_from ActiveRecord::RecordNotFound, :with => :bad_record
  #protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }

  protected
  def render_json(json)
    callback = params[:callback]
    response = begin
      if callback
        "#{callback}(#{json});"
      else
        json
      end
    end
    render({:content_type => 'application/json', :text => response})
  end

  def no_route_found
    render_json({:msg => "No Route Found! Please check used API url", :success => false}.to_json)
  end

  def bad_record
    render_json({:msg => "No Record Found!", :success => false}.to_json)
  end

  def define_current_user
    @token = AuthenticationToken.find_by(:auth_token => params[:auth_token]) rescue nil
    if @token.present?
      @user = User.find(@token.user_id) rescue nil
      unless @user.present?
        render_json(:msg => "No user found with this #{params[:auth_token]} auth token", :success => false)
        return
      end
    else
      render_json(:msg => "Invalid authtoken", :success => false)
      return
    end
  end
end
