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

  describe 'Shows friends' do
    before :each do

      visit '/register'
      @email1 = 'test1@test.com'
      fill_in 'user[email]', with: @email1
      fill_in 'user[password]', with: '1234'
      fill_in 'user[password_confirmation]', with: '1234'
      click_on 'Create User'

      visit '/register'
      email2 = 'test2@test.com'
      fill_in 'user[email]', with: email2
      fill_in 'user[password]', with: '1234'
      fill_in 'user[password_confirmation]', with: '1234'
      click_on 'Create User'

      visit '/register'

      main_email = 'amaf@test.com'
      fill_in 'user[email]', with: main_email
      fill_in 'user[password]', with: '1234'
      fill_in 'user[password_confirmation]', with: '1234'
      click_on 'Create User'

    end

    it 'shows registered users that are friends' do
      expect(page).to have_content('Welcome amaf@test.com')
      expect(page).to have_content('Your friends:')
      expect(page).to have_content('You have friends (but AMAFlix still loves you')
      expect(page).to have_field(:email)
      fill_in :email, with: @email1
      expect(page).to have_button('Add Friend') #ADD HREF LINK HERE
      click_button 'Add Friend'
      save_and_open_page
      expect(page).to have_content(@email1)
    end
  end
end
