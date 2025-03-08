class CitiesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

    def index
      city=City.all
      render json: city.to_json(except: [ :created_at, :updated_at ])
    end

    def show
        city = City.find(params[:id])
        render json: city.to_json(except: [ :created_at, :updated_at ], include: [ employees: { except: [ :created_at, :updated_at ] } ])
    end
     private

    def city_params
        params.permit(:name, :branch_name, :country)
    end

    def render_not_found
        render json: { error: "City not found" }, status: :not_found
    end

    def render_unprocessable_entity(invalid)
      render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end
end
