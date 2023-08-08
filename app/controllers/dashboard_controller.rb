class DashboardController < ApplicationController
  before_action :logged_in_user,  only: [:admin]
  before_action :admin_user,      only: [:admin]

  def home
    @showings = Showing.paginate(page: params[:page], per_page: 5)
    @movies = Movie.paginate(page: params[:page], per_page: 5)
    @cinemas = Cinema.paginate(page: params[:page], per_page: 5)
  end
end
