class MovieService
  def self.top40(page)
    response = Faraday.get "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['MOVIE_API_KEY']}&page=#{page}"
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.search(query, page)
    response = Faraday.get "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['MOVIE_API_KEY']}&query=#{query}&page=#{page}"
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.details(id)
    response = Faraday.get "https://api.themoviedb.org/3/movie/#{id}?api_key=#{ENV['MOVIE_API_KEY']}"
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.first_ten_cast(id)
    response = Faraday.get "https://api.themoviedb.org/3/movie/#{id}/credits?api_key=#{ENV['MOVIE_API_KEY']}"
    credits = JSON.parse(response.body, symbolize_names: true)
    if credits[:cast].count > 10
      credits[:cast].take(10)
    else
      credits[:cast]
    end
  end

  def self.reviews(id)
    response = Faraday.get "https://api.themoviedb.org/3/movie/#{id}/reviews?api_key=#{ENV['MOVIE_API_KEY']}"
    review_summary = JSON.parse(response.body, symbolize_names: true)
    review_summary[:results]
  end
end
