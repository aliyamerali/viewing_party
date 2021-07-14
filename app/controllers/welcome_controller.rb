class WelcomeController < ApplicationController
  skip_before_action :require_login, raise: false
  
  def index; end
end
