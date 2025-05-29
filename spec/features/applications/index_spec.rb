require 'rails_helper'

RSpec.describe 'the application index' do
  it 'lists all the applications by name' do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)

    application = Application.create(name: 'Wade Smith', address: '123 Main Rd.', city: 'Denver', state: 'CO',
                                     zip: '00000', description: "bleh bleh bleh", status: 'In Progress')

    ApplicationPet.create!(application: application, pet: pet_1)

    visit "/applications"

    expect(page).to have_content(application.name)
  end
end
