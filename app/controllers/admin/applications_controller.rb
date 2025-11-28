class Admin::ApplicationsController < ApplicationController

    def show
        @application = Application.find(params[:id])
        @pet = @application.pets
    end

    def update
        @application = Application.find(params[:id])
        @application.update(status: "Approved")

        redirect_to "/admin/applicaitons/#{@application.id}"
    end

    private

    def application_params
        params.permit(:id, :name, :address, :city, :state, :zip, :description, :status)
    end

end