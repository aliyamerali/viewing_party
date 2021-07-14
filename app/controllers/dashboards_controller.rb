class DashboardsController < ApplicationController
  def index
    @user = current_user
    @hosting_parties = @user.parties if current_user
    @attending_parties = @user.attending_parties if current_user
  end
end
