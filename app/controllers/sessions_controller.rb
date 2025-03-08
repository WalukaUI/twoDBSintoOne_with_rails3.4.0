class SessionsController < ApplicationController
  skip_before_action :authorize, only: :create
  def create
      if params[:patient]
        @patient = Patient.find_by(email: params[:email])
        if @patient&.authenticate(params[:password])
          session[:meuser_id] = @patient.id
          render json: @patient, status: :created
        else
          render json: { error: "Invalid email or password" }, status: :unauthorized
        end
      elsif params[:doctor]
        @doctor = Doctor.find_by(email: params[:email])
        if @doctor&.authenticate(params[:password])
          session[:docuser_id] = @doctor.id
          render json: @doctor, status: :created
        else
          render json: { error: "Invalid email or password" }, status: :unauthorized
        end
      elsif params[:user]
        user = User.find_by(name: params[:name])
        if user&.authenticate(params[:password])
           session[:cncuser_id] = user.id
           render json: user, status: :created
        else
           render json: { error: "Invalid name or password" }, status: :unauthorized
        end
      end
  end

  def doc_destroy
      session.delete :docuser_id
      render json: { message: "deleted" }
      head :no_content
  end

  def me_destroy
    session.delete :meuser_id
    render json: { message: "deleted" }
    head :no_content
end

  def cnc_user_destroy
    session.delete :cncuser_id
    render json: { message: "deleted" }
    head :no_content
end
end
