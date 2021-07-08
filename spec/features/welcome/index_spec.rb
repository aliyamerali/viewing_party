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
    expect(page).to have_content("Welcome to Viewing Party")
  end

  it 'has an app description' do
    expect(page).to have_css(".description")
  end

  it 'has a button to login' do
    expect(page).to have_field("Email")
    expect(page).to have_field("Password")
    expect(page).to have_button("Sign In")
  end

  it 'has a link to register' do
    expect(page).to have_link("New to Viewing Party? Register Here.", :href=>"/register" )
  end
end
