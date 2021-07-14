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
    expect(page).to have_button("Log Out")
    expect(page).to_not have_field(:email)
    expect(page).to_not have_field(:password)
    expect(page).to_not have_link("New to AMAFlix? Register Here.", :href=>"/register" )
  end

  it 'does not create a user for an email that already exists' do
    visit '/register'

    fill_in 'user[email]', with: 'amaf@test.com'
    fill_in 'user[password]', with: '1234'
    fill_in 'user[password_confirmation]', with: '1234'
    click_on 'Create User'
    click_on 'Log Out'

    visit '/register'

    fill_in 'user[email]', with: 'amaf@test.com'
    fill_in 'user[password]', with: '5678'
    fill_in 'user[password_confirmation]', with: '5678'
    click_on 'Create User'

    expect(current_path).to eq(root_path)
    expect(page).to have_field(:email)
    expect(page).to have_field(:password)
    expect(page).to have_button('Sign In')
  end

  it 'does not create a user if password and password_confirmation do not match' do
    visit '/register'

    fill_in 'user[email]', with: 'amaf@test.com'
    fill_in 'user[password]', with: '5678'
    fill_in 'user[password_confirmation]', with: '56789'
    click_on 'Create User'

    expect(current_path).to eq(root_path)
    expect(page).to have_field(:email)
    expect(page).to have_field(:password)
    expect(page).to have_button('Sign In')
  end
end
