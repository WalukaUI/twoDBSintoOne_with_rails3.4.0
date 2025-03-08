class DoctorsController < ApplicationController
    skip_before_action :authorize, only: [ :show, :index, :create, :sessionshow ]
    ## before_action :authorize, only: [:show, :index, :create, :sessionshow]

    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
    def index
        if params[:location_id]
          location = Location.find(params[:location_id])
          doctor = location.doctors
        elsif params[:patient_id]
          patient = Patient.find(params[:patient_id])
          doctor = patient.doctors
        else
          doctor = Doctor.all
        end
          render json: doctor.to_json(except: [ :created_at, :updated_at, :password_digest ])
    end
    def sessionshow
      doctor = Doctor.find_by(id: session[:docuser_id])
      render json: doctor.to_json(except: [ :created_at, :updated_at, :password_digest ], include: [ appointments: { except: [ :created_at, :updated_at ] } ], include: [ comment: { except: [ :created_at, :updated_at ] } ]), status: 200
    end

    def show
          # doctor = Doctor.find(params[:id])
          doctor = Doctor.find_by(id: params[:id])
          render json: doctor.to_json(except: [ :created_at, :updated_at, :password_digest ], include: [ appointments: { except: [ :created_at, :updated_at ] } ], include: [ comment: { except: [ :created_at, :updated_at ] } ]), status: 200
    end

    def create
      doctor = Doctor.create(doctor_params)
        if doctor.valid?
          session[:docuser_id] = doctor.id
          render json: doctor.to_json(except: [ :created_at, :updated_at, :password_digest ]), status: :created
        else
          render json: { error: doctor.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def update
        doctor = Doctor.find(params[:id])
        doctor.update!(doctor_params)
        render json: doctor.to_json(except: [ :created_at, :updated_at, :password_digest ])
    end

    def destroy
        doctor = Doctor.destroy(params[:id])
        render json: { message: "doctor deleted" }
    end

    def location_index
        doctor = Location.find(params[:location_id])
        location=doctor.locations
        render json: location(except: [ :created_at, :updated_at ])
    end

    private

    def doctor_params
        params.permit(:first_name, :last_name, :email, :education, :speciality, :role, :username, :password, :password_confirmation)
    end

    def render_not_found
        render json: { error: "Doctor not found" }, status: :not_found
    end

    def render_unprocessable_entity(invalid)
      render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end
end
