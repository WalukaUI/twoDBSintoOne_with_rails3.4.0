class ApplicationController < ActionController::API
  include ActionController::Cookies
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  before_action :authorize

  private

  def authorize
      @current_user = Doctor.find_by(id: session[:docuser_id])
      @current_user1 = Patient.find_by(id: session[:meuser_id])
      @current_user2 = User.find_by(id: session[:cncuser_id])
      render json: { errors: [ "Not authorized" ] }, status: :unauthorized unless @current_user || @current_user1 || @current_user2
  end

  def render_unprocessable_entity_response(exception)
      render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end
end
