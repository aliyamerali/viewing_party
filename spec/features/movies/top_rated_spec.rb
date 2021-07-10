require 'rails_helper'

RSpec.describe do

  it 'returns top 40 movies' do
    response_body = File.read('spec/fixtures/top_rated.json')
    stub_request(:get,'https://api.themoviedb.org/3/movie/top_rated').
        to_return(status: 200, body: response_body, headers: {})
  end
end
