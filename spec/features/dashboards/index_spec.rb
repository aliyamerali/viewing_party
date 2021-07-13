require 'rails_helper'

RSpec.describe "Dashboard page" do
  describe 'Authenticated User view' do
    it 'has a welcome message and logout button' do
      visit '/register'

      email = 'amaf@test.com'
      fill_in 'user[email]', with: email
      fill_in 'user[password]', with: '1234'
      fill_in 'user[password_confirmation]', with: '1234'
      click_on 'Create User'

      visit dashboard_path
      expect(page).to have_content("Welcome #{email}!")
      expect(page).to have_button("Log Out")
    end

    it 'has a button to discover movies' do
      visit '/register'

      email = 'amaf@test.com'
      fill_in 'user[email]', with: email
      fill_in 'user[password]', with: '1234'
      fill_in 'user[password_confirmation]', with: '1234'
      click_on 'Create User'

      visit dashboard_path
      expect(page).to have_button("Discover Movies")
    end
  end

  describe 'Unauthenticated User view' do

    it 'has a button to login' do
      visit dashboard_path
      expect(page).to have_field(:email)
      expect(page).to have_field(:password)
      expect(page).to have_button("Sign In")
    end

    it 'has a link to register' do
      visit dashboard_path
      expect(page).to have_link("New to AMAFlix? Register Here.", :href=>"/register" )
    end
  end
end
