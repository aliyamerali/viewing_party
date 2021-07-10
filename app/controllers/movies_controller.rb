class MoviesController < ApplicationController
  before_action :require_login

  def show; end

  def new_search
    # TBD
  end

  def search
    if params[:search]
      @movies = MovieService.search(params[:search])
    else
      @movies = MovieService.top40
    end
  end

  private

  def require_login
    redirect_to '/register' if current_user.nil?
  end
end
