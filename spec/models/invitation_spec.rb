require 'rails_helper'

RSpec.describe Invitation do
  describe 'relationships' do
    it {should belong_to(:user)}
    it {should belong_to(:party)}
  end
end
