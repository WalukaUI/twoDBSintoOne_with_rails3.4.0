class ProjectsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

    def index
      if params[:employee_id]
        employee = Employee.find(params[:employee_id])
        project = employee.projects
      else
        project = Project.all
      end
      render json: project
    end

    def show
        project = Project.find(params[:id])
        render json: project.to_json(except: [ :created_at, :updated_at ]), status: 200
    end

    def create
        project = Project.create(project_params)
        render json: project.to_json(except: [ :created_at, :updated_at ]), status: 201
    end

    def employee_index
      project = Project.find(params[:project_id])
      employee= project.employees
      render json: employee
    end

     private

    def project_params
        params.permit(:name, :section, :role, :department_id, :city_id)
    end

    def render_not_found
        render json: { error: "Project is not found" }, status: :not_found
    end

    def render_unprocessable_entity(invalid)
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end
end
