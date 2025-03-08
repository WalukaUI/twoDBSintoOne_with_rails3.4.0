class LocationsController < ApplicationController
    skip_before_action :authorize, only: [ :show, :index ]
    ## before_action :authorize, only: [:show, :index]
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

    def index
        if params[:doctor_id]
          doctor = Doctor.find(params[:doctor_id])
          location = doctor.locations
        else
          location = Location.all
        end
        render json: location.to_json(except: [ :created_at, :updated_at ])
    end

    def show
        location = Location.find(params[:id])
        render json: location.to_json(except: [ :created_at, :updated_at ]), status: 200
    end

    def create
        location = Location.create(location_params)
        render json: location.to_json(except: [ :created_at, :updated_at ]), status: 201
    end

    def update
        location = Location.find(params[:id])
        location.update!(location_params)
        render json: location.to_json(except: [ :created_at, :updated_at ])
    end

    def destroy
        location = Location.destroy(params[:id])
        render json: { message: "Location deleted" }
    end

    def doctor_index
        location = Location.find(params[:location_id])
        doctor= location.doctors
        render json: doctor
    end

    private

    def location_params
        params.permit(:name, :address_line_one, :address_line_two, :city, :zipcode, :contact_number, :latitude, :longitude)
    end

    def render_not_found
        render json: { error: "Location is not found" }, status: :not_found
    end

    def render_unprocessable_entity(invalid)
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end
end
