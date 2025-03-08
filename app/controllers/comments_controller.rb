class CommentsController < ApplicationController
    before_action :authorize, only: [ :show, :index ]
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

    def index
        comment = Comment.all
        render json: comment.to_json(except: [ :created_at, :updated_at ])
    end

    def show
        comment = Comment.find(params[:id])
        render json: comment.to_json(except: [ :created_at, :updated_at ]), status: 200
    end

    def create
        comment = Comment.create(comment_params)
        render json: comment.to_json(except: [ :created_at, :updated_at ]), status: 201
    end

    def update
        comment = Comment.find(params[:id])
        comment.update!(comment_params)
        render json: comment.to_json(except: [ :created_at, :updated_at ])
    end

    def destroy
        comment = Comment.destroy(params[:id])
        render json: { message: "Comment deleted" }
    end

    private

    def comment_params
        params.permit(:doctor_id, :patient_id, :comment, :points)
    end

    def render_not_found
        render json: { error: "Comment is not found" }, status: :not_found
    end

    def render_unprocessable_entity(invalid)
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end
end
