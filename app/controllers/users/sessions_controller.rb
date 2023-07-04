class Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token
  include ActionController::Flash

  respond_to :json

  def create
    user = User.find_by(email: params[:user][:email])
    if user && user.academic.present? && user.valid_password?(params[:user][:password])
      sign_in user
      render json: {
       user: user,
       academic: user.academic
      }, status: 200
    elsif user && user.valid_password?(params[:user][:password])
      render json: {
        message: 'Add academic record to log in' 
      },status: 404
    else
      render json:{
        message: "invalid password or email"
      },status: 401
    end
  end

  private

  def respond_with(resource, _opts = {})
    render json: {
      status: {code: 200, message: 'Logged in sucessfully.'},
      data: resource
    }
  end

  def respond_to_on_destroy
    if current_user
      render json: {
        status: 200,
        message: "logged out successfully"
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end
end