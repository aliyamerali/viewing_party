require 'rails_helper'

RSpec.describe 'registration page' do
  it 'has correct form' do
    visit '/register'

    expect(page).to have_field('user[email]')
    expect(page).to have_field('user[password]')
    expect(page).to have_field('user[password_confirmation]')
    expect(page).to have_button('Create User')
  end

  it 'creates new user on form submission and logs them in' do
    visit '/register'

    fill_in 'user[email]', with: 'amaf@test.com'
    fill_in 'user[password]', with: '1234'
    fill_in 'user[password_confirmation]', with: '1234'
    click_on 'Create User'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Welcome, amaf@test.com!")
    expect(page).to have_button("Log Out")
    expect(page).to_not have_field(:email)
    expect(page).to_not have_field(:password)
    expect(page).to_not have_link("New to AMAFlix? Register Here.", :href=>"/register" )
  end
end

#add test for sad path for unmatching pw and pwconfirm
