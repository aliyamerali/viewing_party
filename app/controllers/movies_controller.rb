class MoviesController < ApplicationController
  before_action :require_login

  def show

  end

  def new_search

  end
  
  def search

  end

  private
  def require_login
    if current_user.nil?
      redirect_to '/register'
    end
  end
end


# As an authenticated user,
# When I visit the movies page,
# I should see the 40 results from my search,
# I should also see the "Find Top Rated Movies"
# button and the Find Movies form at the top of the page.
#
# Details: The results from the search should appear
# on this page, and there should only be a maximum of 40 results. The following details should be listed for each movie.
#
#  Title (As a Link to the Movie Details page)
#  Vote Average of the movie
