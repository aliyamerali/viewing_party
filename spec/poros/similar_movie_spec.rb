require 'rails_helper'

RSpec.describe 'Similar Movie PORO' do
  it 'has attributes of cast member' do
    attributes = {author: "Reviewer Name", content: "Movie Review"}
    review = Review.new(attributes)

    expect(review.author).to eq(attributes[:author])
    expect(review.author).to be_a String
    expect(review.content).to eq(attributes[:content])
    expect(review.content).to be_a String
  end
end
