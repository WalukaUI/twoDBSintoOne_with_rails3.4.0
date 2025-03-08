class EmployeesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

    def index
      if params[:project_id]
        employee = Project.find(params[:project_id])
        employee = employee.employees
      else
        employee =Employee.all
      end
      render json: employee.to_json(except: [ :created_at, :updated_at ])
    end

    def show
        employee = Employee.find(params[:id])
        render json: employee, include: :city
    end

    def create
        employee = Employee.create!(employee_params)
        render json: employee.to_json(except: [ :created_at, :updated_at ]), status: :created
    end

    def update
      employee = Employee.find(params[:id])
      employee.update!(employee_params)
      render json: employee.to_json(except: [ :created_at, :updated_at ])
    end

    def destroy
      # empl=Employee.find(params[:id])
      # DeleteEmployeeMailer.delete_employee(empl).deliver_now
      employee = Employee.destroy(params[:id])
      render json: { message: "Employee deleted" }
    end

    def projects_index
      employee = Employee.find(params[:employee_id])
      project = employee.projects
      render json: project
    end

     private

    def employee_params
        params.permit(:name, :section, :role, :department_id, :city_id)
    end

    def render_not_found
        render json: { error: "Employee is not found" }, status: :not_found
    end

    def render_unprocessable_entity(invalid)
        render json: { errors: invalid.record.errors }, status: :unprocessable_entity
    end
end
