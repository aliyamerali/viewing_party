class MoviesController < ApplicationController
  before_action :require_login

  def show
    @details = MovieService.details(params[:id])
    @cast = MovieService.first_ten_cast(params[:id])
    @reviews = MovieService.reviews(params[:id])
  end

  def new_search; end

  def search
    @movies = if params[:search]
                MovieService.search(params[:search])
              else
                MovieService.top40
              end
  end

  private

  def require_login
    redirect_to root_path if current_user.nil?
    flash[:error] = 'Please log in to continue' if current_user.nil?
  end
end
