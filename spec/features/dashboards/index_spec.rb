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

    it 'shows viewing parties' do
      visit '/register'

      email = 'amaf@test.com'
      fill_in 'user[email]', with: email
      fill_in 'user[password]', with: '1234'
      fill_in 'user[password_confirmation]', with: '1234'
      click_on 'Create User'

      visit dashboard_path
      expect(page).to have_content("Viewing Parties:")
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
        expect(page).to have_content('You currently have no friends (but AMAFlix still loves you).')
        expect(page).to have_field(:email)
        fill_in :email, with: @email1
        expect(page).to have_button('Add Friend')
        click_button 'Add Friend'
        expect(page).to have_content(@email1)
        expect(page).to_not have_content('You currently have no friends (but AMAFlix still loves you).')
      end

      it 'does not allow user to add friends that are not registered' do
        fill_in :email, with: 'nonuser@test.com'
        click_button 'Add Friend'

        expect(page).to have_content('User does not exist')
      end
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

    it 'does not have party, friend, or discover content' do
      visit dashboard_path
      expect(page).to_not have_button("Discover Movies")
      expect(page).to_not have_content("Viewing Parties:")
      expect(page).to_not have_content('Your friends:')
    end
  end
end
