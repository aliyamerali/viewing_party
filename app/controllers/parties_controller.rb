class PartiesController < ApplicationController
  def new
    @movie = MovieFacade.details(params[:movie_id])
    @party = Party.new
    @user = current_user
  end

  def create
    party = Party.new(party_params)
    if party.save
      params[:party][:friend].each do |friend_id|
        Invitation.create!(party_id: party.id, guest_id: friend_id)
      end
      redirect_to dashboard_path
    else
      flash[:error] = 'Invalid party parameters'
      redirect_to "/parties/new?movie_id=#{params[:party][:movie_id]}"
    end
  end

  private

  def party_params
    params.require(:party).permit(:host_id, :movie_id, :movie_title, :duration, :date, :event_time)
  end
end
