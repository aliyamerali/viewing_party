class MovieService
  def self.top40(page)
    response = Faraday.get "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['MOVIE_API_KEY']}&page=#{page}"
    parse(response)
  end

  def self.search(query, page)
    response = Faraday.get "https://api.themoviedb.org/3/search/movie?api_key=#{ENV['MOVIE_API_KEY']}&query=#{query}&page=#{page}"
    parse(response)
  end

  def self.details(id)
    response = Faraday.get "https://api.themoviedb.org/3/movie/#{id}?api_key=#{ENV['MOVIE_API_KEY']}"
    parse(response)
  end

  def self.credits(id)
    response = Faraday.get "https://api.themoviedb.org/3/movie/#{id}/credits?api_key=#{ENV['MOVIE_API_KEY']}"
    parse(response)
  end

  def self.reviews(id)
    response = Faraday.get "https://api.themoviedb.org/3/movie/#{id}/reviews?api_key=#{ENV['MOVIE_API_KEY']}"
    parse(response)
  end

  def self.similar(id)
    response = Faraday.get "https://api.themoviedb.org/3/movie/#{id}/similar?api_key=#{ENV['MOVIE_API_KEY']}"
    parse(response)
  end

  def private_class_method.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
