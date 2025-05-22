require 'rails_helper'

RSpec.describe 'Application new page' do
  it 'Shows a form for a new application' do
    visit '/pets'

    click_link 'Start an Application'

    expect(page).to have_current_path("/applications/new")

    fill_in('Name', with: "Jack Wade")
    fill_in('Address', with: '69 Oak St.')
    fill_in('City', with: 'Gary')
    fill_in('State', with: 'IN')
    fill_in('Zip', with: '46401')
    fill_in('Description', with: "I have many high stacks and bands")

    click_button 'Submit'

    expect(page).to have_content('Jack Wade')
    expect(page).to have_content('69 Oak St.')
    expect(page).to have_content('Gary')
    expect(page).to have_content('IN')
    expect(page).to have_content('46401')
    expect(page).to have_content('I have many high stacks and bands')
    expect(page).to have_content('In Progress')
  end
  
  it 'shows an error after not fully completing form' do
    visit "/applications/new"

    click_button 'Submit'

    expect(page).to have_current_path('/applications/new')
    expect(page).to have_content('You have NOT fully completed your application!!!')

  end
end