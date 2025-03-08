class DepartmentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

    def index
      department=Department.all
      render json: department.to_json(except: [ :created_at, :updated_at ])
    end

    def show
        department = Department.find(params[:id])
        render json: department.to_json(except: [ :created_at, :updated_at ], include: [ employees: { except: [ :created_at, :updated_at ] } ])
    end

    def create
        department = Department.create(department_params)
        render json: department.to_json(except: [ :created_at, :updated_at ])
    end
     private

    def department_params
        params.permit(:name, :dept_manager_name)
    end

    def render_not_found
        render json: { error: "Department is not found" }, status: :not_found
    end

    def render_unprocessable_entity(invalid)
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end
end
