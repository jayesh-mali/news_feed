class ApplicationController < ActionController::API
  
  include Pundit

  include DeviseTokenAuth::Concerns::SetUserByToken
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized


  def user_not_authorized
    render :json => {:errors => ["You are not authorized to perform this action."]}, :status => :forbidden
  end
  
end
