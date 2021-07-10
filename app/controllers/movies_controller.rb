class MoviesController < ApplicationController
  before_action :require_login

  def show; end

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
    flash[:error] = 'Please log in to continue'
    redirect_to root_path if current_user.nil?
  end
end
