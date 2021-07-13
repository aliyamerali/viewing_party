class PartiesController < ApplicationController
  def new
    @movie = MovieFacade.details(params[:movie_id])
    @party = Party.new
  end

  def create
  end
end
