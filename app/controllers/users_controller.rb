class UsersController < ApplicationController
     skip_before_action :authorize, only: :create
    # before_action :authorize, only: [ :show, :create ]

    def index
        user=User.all
        render json: user
    end

    def create
        user = User.create(user_params)
        if user.valid?
            # WelcomeMailer.welcome_email(user).deliver_later
            session[:cncuser_id] = user.id
            render json: user, status: :created
        else
            render json: { error: user.errors.full_messages }, status: :unprocessable_entity
        end
    end
    def destroy
        user = User.destroy(params[:id])
        render json: { message: "User deleted" }
    end
    def show
        user = User.find_by(id: session[:cncuser_id])
        render json: user
    end

    private
    def authorize
        render json: { error: "Not authorized" }, status: :unauthorized unless session.include? :cncuser_id
    end

    def user_params
        params.permit(:name, :password, :password_confirmation, :username, :email, :position, :user)
    end
end
