class DashboardsController < ApplicationController
  def index
    @user = current_user
    @hosting_parties = @user.parties if current_user
    @attending_parties = @user.attending_parties if current_user
    if !@user.nil?
      @friends = @user.friends_list
    end
  end

  def add_friend
    @user = current_user
    @friend = User.find_by(email: params[:email])
    Friend.create!(friender_id: @user.id, friendee_id: @friend.id)
    redirect_to dashboard_path
  end
end
