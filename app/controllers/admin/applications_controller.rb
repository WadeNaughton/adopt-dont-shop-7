class Admin::ApplicationsController < ApplicationController

    def show
        @application = Application.find(params[:id])
        @pet = @application.pets

    end

    def update
        @application = Application.find(params[:id])

        @application.application_pets.update(status: "Approved") if params[:stat] == "approve"
        @application.application_pets.update(status: "Reject") if params[:stat] == "reject"

        redirect_to "/admin/applications/#{@application.id}"
    end

    private

    def application_params
        params.permit(:id, :name, :address, :city, :state, :zip, :description, :status)
    end

end