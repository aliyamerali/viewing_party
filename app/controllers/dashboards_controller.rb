class DashboardsController < ApplicationController
  def index
    @user = current_user
    @parties = Party.where('host_id = ?', @user.id) if current_user
  end
end
