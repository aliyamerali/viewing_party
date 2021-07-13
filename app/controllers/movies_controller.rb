class MoviesController < ApplicationController
  before_action :require_login

  def show
    @movie = MovieFacade.details(params[:id])
    @cast = MovieFacade.first_ten_cast(params[:id])
    @reviews = MovieService.reviews(params[:id])
  end

  def new_search; end

  def search
    @movies = if params[:search]
                MovieFacade.search(params[:search])
              else
                MovieFacade.top40
              end
  end

  private

  def require_login
    redirect_to root_path if current_user.nil?
    flash[:error] = 'Please log in to continue' if current_user.nil?
  end
end
