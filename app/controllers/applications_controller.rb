class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end
  
  def show
    @application = Application.find(params[:id])

    if params[:query].present?
      @pets = Pet.where('LOWER(name) LIKE :query', query: "%#{params[:query].downcase}%")
    end
  end

  def new

  end

  def update
    @pet = Pet.find(params[:pet_id])
    @application = Application.find(params[:id])

    ApplicationPet.create(application: @application, pet: @pet)
    redirect_to "/applications/#{@application.id}"
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