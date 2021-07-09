require 'rails_helper'

RSpec.describe User do
  describe "validations" do
    it {should validate_presence_of(:email)}
    it {should validate_uniqueness_of(:email)}
    it {should validate_presence_of(:password)}
  end
  describe 'relationships' do
    it {should have_many(:friended_users).class_name('Friend')}
    it {should have_many(:friendees).through(:friended_users)}
    it {should have_many(:friending_users).class_name('Friend')}
    it {should have_many(:frienders).through(:friending_users)}

    it {should have_many(:invitations)}
    it {should have_many(:parties)}
  end
end
