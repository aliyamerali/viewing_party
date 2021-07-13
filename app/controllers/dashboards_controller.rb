class DashboardsController < ApplicationController
  def index
    if current_user
      @user = current_user
      @parties = Party.where('host_id = ?', @user.id)
    else
      @user = current_user
    end
  end
end
