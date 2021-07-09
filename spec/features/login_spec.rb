require 'rails_helper'

RSpec.describe "logging in" do
  it 'logs a user in if they are registered' do
    user = User.create(email: 'amaf@test.com', password: '1234', password_confirmation: '1234')

    visit root_path

    fill_in :email, with: 'amaf@test.com'
    fill_in :password, with: '1234'
    click_button "Sign In"

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Welcome, amaf@test.com!")
    expect(page).to have_button("Log Out")
    expect(page).to_not have_field(:email)
    expect(page).to_not have_field(:password)
    expect(page).to_not have_link("New to AMAFlix? Register Here.", :href=>"/register" )
  end

  it 'does not log in a user that is not registered' do
    visit root_path

    fill_in :email, with: 'not_created@test.com'
    fill_in :password, with: '1234'
    click_button "Sign In"

    expect(current_path).to eq('/')
    expect(page).to have_content("Invalid Credentials")
    expect(page).to have_field(:email)
    expect(page).to have_field(:password)
    expect(page).to have_link("New to AMAFlix? Register Here.", :href=>"/register" )
    expect(page).to_not have_button("Log Out")
  end

  it 'does not log in a user with incorrect password' do
    user = User.create(email: 'amaf@test.com', password: '1234', password_confirmation: '1234')

    visit root_path

    fill_in :email, with: 'amaf@test.com'
    fill_in :password, with: '5678'
    click_button "Sign In"

    expect(current_path).to eq('/')
    expect(page).to have_content("Invalid Credentials")
    expect(page).to have_field(:email)
    expect(page).to have_field(:password)
    expect(page).to have_link("New to AMAFlix? Register Here.", :href=>"/register" )
    expect(page).to_not have_button("Log Out")
  end

  it 'does not log in a user with incorrect email' do
    user = User.create(email: 'amaf@test.com', password: '1234', password_confirmation: '1234')

    visit root_path

    fill_in :email, with: 'amaf_1@test.com'
    fill_in :password, with: '1234'
    click_button "Sign In"

    expect(current_path).to eq('/')
    expect(page).to have_content("Invalid Credentials")
    expect(page).to have_field(:email)
    expect(page).to have_field(:password)
    expect(page).to have_link("New to AMAFlix? Register Here.", :href=>"/register" )
    expect(page).to_not have_button("Log Out")
  end
end
