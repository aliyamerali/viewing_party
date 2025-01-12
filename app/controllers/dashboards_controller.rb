class DashboardsController < ApplicationController
  def index
    @user = current_user
    @hosting_parties = @user.parties if current_user
    @attending_parties = @user.attending_parties if current_user
    @friends = @user.friends_list if current_user
  end

  def add_friend
    @user = current_user
    @friend = User.find_by(email: params[:email])
    if @friend
      Friend.create!(friender_id: @user.id, friendee_id: @friend.id)
    else
      flash[:error] = 'Unable to add friend: User does not exist'
    end
    redirect_to dashboard_path
  end
end
