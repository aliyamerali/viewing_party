require 'rails_helper'

RSpec.describe 'Movie PORO' do
  it 'has attributes of movie with nil values for attributes not entered' do
    attributes = {id: 12, title: "The Movie", vote_average: 5.5}
    movie = Movie.new(attributes)

    expect(movie.id).to eq(attributes[:id])
    expect(movie.id).to be_a Integer
    expect(movie.title).to eq(attributes[:title])
    expect(movie.title).to be_a String
    expect(movie.vote_average).to eq(attributes[:vote_average])
    expect(movie.vote_average).to be_a Float
    expect(movie.runtime).to eq(nil)
    expect(movie.genres).to eq(nil)
    expect(movie.overview).to eq(nil)
  end

  it 'has attributes of movie when all attributes entered' do
    attributes = {id: 12,
                  title: "The Movie",
                  vote_average: 5.5,
                  runtime: 123,
                  genres: [
                      {"id": 12, "name": "Adventure"},
                      {"id": 14, "name": "Thrill"}],
                  overview: "A good movie"
                  }
    movie = Movie.new(attributes)

    expect(movie.id).to eq(attributes[:id])
    expect(movie.id).to be_a Integer
    expect(movie.title).to eq(attributes[:title])
    expect(movie.title).to be_a String
    expect(movie.vote_average).to eq(attributes[:vote_average])
    expect(movie.vote_average).to be_a Float
    expect(movie.runtime).to eq({hours: 2, minutes: 3})
    expect(movie.runtime).to be_a Hash
    expect(movie.genres).to eq(["Adventure", "Thrill"])
    expect(movie.genres).to be_a Array
    expect(movie.overview).to eq(attributes[:overview])
    expect(movie.overview).to be_a String
  end
end
