class MoviesController < ApplicationController
  before_action :require_login

  def show; end

  def new_search; end

  def search
    if params[:search]
      # query api for search term
    else
      @movies = MovieService.top40
      # return top 40 movies from api - array of hashes/ [{original_title: "", vote_average: }, ...]
    end
  end

  private

  def require_login
    redirect_to '/register' if current_user.nil?
  end
end
