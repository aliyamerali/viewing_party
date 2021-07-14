require 'rails_helper'

RSpec.describe 'Similar Movie PORO' do
  it 'has attributes of cast member' do
    attributes = {id: 1, title: "Test Movie", overview: "It's a real winner", vote_average: 8.7}
    movie = SimilarMovie.new(attributes)
    expect(movie.id).to eq(attributes[:id])
    expect(movie.id).to be_a(Integer)
    expect(movie.title).to eq(attributes[:title])
    expect(movie.title).to be_a String
    expect(movie.overview).to eq(attributes[:overview])
    expect(movie.overview).to be_a(String)
    expect(movie.vote_average).to eq(attributes[:vote_average])
    expect(movie.vote_average).to be_a(Float)
  end
end
