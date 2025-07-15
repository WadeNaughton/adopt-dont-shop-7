class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end
  
  def show
    @application = Application.find(params[:id])
    if params[:query].present?
      @pets = Pet.where('LOWER(name) LIKE :query', query: "%#{params[:query].downcase}%")
      if @pets.empty?
        @message_result = 'No results found'
      end
    end
  end

  def new

  end

  def update
    @pet = Pet.find(params[:pet_id])
    @application = Application.find(params[:id])

    if @application.pets.include?(@pet)
      redirect_to "/applications/#{@application.id}"
      flash[:alert] = 'You already added this pet to your application'
    else
      ApplicationPet.create(application: @application, pet: @pet)
      redirect_to "/applications/#{@application.id}"
      flash[:alert] = 'Pet added successfully to application!'
    end
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

  def submit
    application = Application.find(params[:id])
    if application.pets.empty?
      redirect_to "/applications/#{application.id}"
      flash[:alert] = 'You must add at least ONE (1) pet to this application'
    else
      application.update(status: 'Pending')
      redirect_to "/applications/#{application.id}"
      flash[:alert] = 'Application submitted successfully!'
    end
  end

  private
  def application_params
    params.permit(:name, :address, :city, :state, :zip, :description, :status)
  end
end