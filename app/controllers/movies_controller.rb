class MoviesController < ApplicationController
  def show
    @movie = MovieFacade.details(params[:id])
    @cast = MovieFacade.first_ten_cast(params[:id])
    @reviews = MovieFacade.reviews(params[:id])
    @similar_movies = MovieFacade.similar(params[:id])
  end

  def new_search; end

  def search
    @movies = if params[:search]
                MovieFacade.search(params[:search])
              else
                MovieFacade.top40
              end
  end
end
