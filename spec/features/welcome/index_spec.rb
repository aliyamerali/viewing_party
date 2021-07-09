require 'rails_helper'

RSpec.describe "Welcome page" do
  before :each do
    visit root_path
  end

  # Welcome message
  # Brief description of the application
  # Button to Log in
  # Link to Registration

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
