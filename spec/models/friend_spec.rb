require 'rails_helper'

RSpec.describe Friend do
  describe 'relationships' do
    it {should belong_to(:friender).class_name('User')}
    it {should belong_to(:friendee).class_name('User')}
  end
end
