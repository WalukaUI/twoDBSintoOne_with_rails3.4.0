class CountriesController < ApplicationController
    # skip_before_action :authorize, only: :index
    before_action :authorize, only: [ :show ]
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

    def index
      country=Country.all
      render json: country.to_json(except: [ :created_at, :updated_at ])
    end

    def show
        country = Country.find(params[:id])
        render json: country.to_json(except: [ :created_at, :updated_at ], include: [ cities: { except: [ :created_at, :updated_at ] } ])
    end

    def create
        country = Country.create(country_params)
        render json: country.to_json(except: [ :created_at, :updated_at ])
    end
     private

    def country_params
        params.permit(:name, :branch_name)
    end

    def render_not_found
        render json: { error: "Country is not found" }, status: :not_found
    end

    def render_unprocessable_entity(invalid)
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end
end
