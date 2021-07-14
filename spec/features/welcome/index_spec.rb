require 'rails_helper'

RSpec.describe "Welcome page" do
  before :each do
    visit root_path
  end

  describe 'unauthenticated user experience' do
    it 'has a welcome message' do
      expect(page).to have_content("Welcome to AMAFlix")
    end

    it 'has an app description' do
      expect(page).to have_css(".description")
    end

    it 'has a button to login' do
      expect(page).to have_field(:email)
      expect(page).to have_field(:password)
      expect(page).to have_button("Sign In")
    end

    it 'has a link to register' do
      expect(page).to have_link("New to AMAFlix? Register Here.", :href=>"/register" )
    end
  end

  describe 'authenticated user experience' do
    it 'has a button to log out, no option to register' do
      visit '/register'

      fill_in 'user[email]', with: 'amaf@test.com'
      fill_in 'user[password]', with: '1234'
      fill_in 'user[password_confirmation]', with: '1234'
      click_on 'Create User'

      visit root_path

      expect(page).to have_button("Log Out")
      expect(page).to_not have_field(:email)
      expect(page).to_not have_field(:password)
      expect(page).to_not have_link("New to AMAFlix? Register Here.", :href=>"/register" )
    end
  end
end
