require 'rails_helper'

RSpec.describe "logging in" do
  it 'logs a user in if they are registered' do
    user = User.create(email: 'amaf@test.com', password: '1234', password_confirmation: '1234')

    visit root_path

    fill_in :email, with: 'amaf@test.com'
    fill_in :password, with: '1234'
    click_button 'Sign In'

    expect(current_path).to eq('/login')
    expect(page).to have_content("Welcome, amaf@test.com!")
    expect(page).to have_button("Log Out")
    expect(page).to_not have_field('user[email]')
    expect(page).to_not have_field('user[password]')
    expect(page).to_not have_link("New to Viewing Party? Register Here.", :href=>"/register" )
  end
end
