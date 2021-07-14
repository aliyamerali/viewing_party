class SimilarMovie
  attr_reader :id, :title, :overview, :vote_average
  def initialize(similar_movie_info)
    @id = similar_movie_info[:id]
    @title = similar_movie_info[:title]
    @overview = similar_movie_info[:overview]
    @vote_average = similar_movie_info[:vote_average]
  end
end
