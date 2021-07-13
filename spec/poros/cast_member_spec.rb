require 'rails_helper'

RSpec.describe 'CastMember PORO' do
  it 'has attributes of cast member' do
    attributes = {name: "Actor", character: "Movie Character"}
    cast_member = CastMember.new(attributes)

    expect(cast_member.character).to eq(attributes[:character])
    expect(cast_member.character).to be_a String
    expect(cast_member.actor).to eq(attributes[:name])
    expect(cast_member.actor).to be_a String
  end
end
