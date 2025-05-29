require 'rails_helper'

RSpec.describe 'Application show page' do
  it 'Shows name of applicant' do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    application = Application.create(name: 'Wade Smith', address: '123 Main Rd.', city: 'Denver', state: 'CO',
                                     zip: '00000', description: 'bleh bleh bleh', status: 'In Progress')
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    ApplicationPet.create(application: application, pet: pet_1)

    visit '/applications'

    expect(page).to have_content(application.name)

    click_link 'Wade Smith'

    expect(page).to have_current_path("/applications/#{application.id}")
  end

  it 'details of the applicant' do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    application = Application.create(name: 'Wade Smith', address: '123 Main Rd.', city: 'Denver', state: 'CO',
                                     zip: '00000', description: 'bleh bleh bleh', status: 'In Progress')
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    ApplicationPet.create(application: application, pet: pet_1)

    visit "/applications/#{application.id}"

    expect(page).to have_content(application.name)
    expect(page).to have_content(application.address)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zip)

    expect(page).to have_content(application.description)
    expect(page).to have_content(application.status)

    expect(page).to have_content(pet_1.name)
  end

  it 'searches for a pet and displays the name of the results' do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    application = Application.create(name: 'Wade Smith', address: '123 Main Rd.', city: 'Denver', state: 'CO',
                                     zip: '00000', description: 'bleh bleh bleh', status: 'In Progress')
    Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)

    visit "/applications/#{application.id}"

    expect(page).to have_content('Add a Pet to this Application')

    fill_in 'Add a Pet to this Application:', with: 'Lucille Bald'

    click_button 'Search'

    expect(page).to have_current_path("/applications/#{application.id}?query=Lucille+Bald&commit=Search")
    expect(page).to have_content('Lucille Bald')
  end

  it 'does not yield any results' do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    application = Application.create(name: 'Wade Smith', address: '123 Main Rd.', city: 'Denver', state: 'CO',
                                     zip: '00000', description: 'bleh bleh bleh', status: 'In Progress')
    Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    Pet.create(adoptable: true, age: 15, breed: 'tuxedo cat', name: 'Mr. O. Malley', shelter_id: shelter.id)
    Pet.create(adoptable: true, age: 1, breed: 'wire-haired pointer', name: 'Roman', shelter_id: shelter.id)

    visit "/applications/#{application.id}"

    fill_in 'Add a Pet to this Application:', with: 'Stan'

    click_button 'Search'

    expect(page).to_not have_content('Lucille Bald')
    expect(page).to_not have_content('Mr. O. Malley')
    expect(page).to_not have_content('Roman')
  end

  it 'yields results regardless of letter case' do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    application = Application.create(name: 'Wade Smith', address: '123 Main Rd.', city: 'Denver', state: 'CO',
                                     zip: '00000', description: 'bleh bleh bleh', status: 'In Progress')
    Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    Pet.create(adoptable: true, age: 15, breed: 'tuxedo cat', name: 'Mr. O. Malley', shelter_id: shelter.id)
    Pet.create(adoptable: true, age: 1, breed: 'wire-haired pointer', name: 'Roman', shelter_id: shelter.id)

    visit "/applications/#{application.id}"

    fill_in 'Add a Pet to this Application:', with: 'roman'

    click_button 'Search'

    expect(page).to have_content('Roman')
  end
end
