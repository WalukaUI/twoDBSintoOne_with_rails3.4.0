class PatientsController < ApplicationController
    ## before_action :authorize, only: [:show, :index, :sessionshow]
    skip_before_action :authorize, only: [ :show, :index, :create, :sessionshow ]
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
    def index
        if params[:doctor_id]
            doctor = Doctor.find(params[:doctor_id])
            patient = doctor.patients
        else
            patient=Patient.all
        end
            render json: patient.to_json(except: [ :created_at, :updated_at, :username, :password_digest ])
    end

    def create
        patient = Patient.create(patient_params)
        puts "====================================done1==================================="
        if patient.valid?
          puts "====================================done2==================================="
            puts "====================================done3==================================="
            session[:meuser_id] = patient.id
            puts "====================================done4==================================="
            render json: patient.to_json(except: [ :created_at, :updated_at, :password_digest ]), status: :created
        else
            render json: { error: patient.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def sessionshow
      patient = Patient.find_by(id: session[:meuser_id])
      render json: patient.to_json(except: [ :created_at, :updated_at, :password_digest ], include: [ appointments: { except: [ :created_at, :updated_at ] } ], include: [ comment: { except: [ :created_at, :updated_at ] } ]), status: 200
    end

    def update
      patient = Patient.find(params[:id])
      patient.update!(patient_params)
      render json: patient.to_json(except: [ :created_at, :updated_at, :password_digest ])
    end

    def destroy
      patient = Patient.destroy(params[:id])
      render json: { message: "Patient deleted" }
    end

    def show
      patient = Patient.find_by(id: session[:meuser_id])
      render json: patient.to_json(except: [ :created_at, :updated_at, :password_digest ], include: [ comment: { except: [ :created_at, :updated_at ] } ])
    end

    private
    def authorize
      render json: { error: "Not authorized" }, status: :unauthorized unless session.include? :meuser_id
    end

    def patient_params
      params.permit(:first_name, :last_name, :username, :email, :contact_number, :clinic_location, :role, :password, :password_confirmation, :doctor_id)
    end

    def render_not_found
      render json: { error: "Patient is not found" }, status: :not_found
    end

    def render_unprocessable_entity(invalid)
      render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end
end
