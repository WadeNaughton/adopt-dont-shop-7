class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end
  
  def show
    @application = Application.find(params[:id])

    if params[:query].present?
      @pets = Pet.where('name LIKE :query', query: "%#{params[:query]}%")
    end
  end

  def new

  end

  def create
    application = Application.new(application_params)

    if application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = 'You have NOT fully completed your application!!!'
  end

  end

  private
  def application_params
    params.permit(:name, :address, :city, :state, :zip, :description, :status)
  end
end