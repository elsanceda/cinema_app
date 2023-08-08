class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show]
  before_action :correct_user,   only: [:show]

  def show
    @user = User.find(params[:id])
    @bookings = @user.bookings.paginate(page: params[:page])
  end    

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      reset_session
      log_in @user
      flash[:success] = "Welcome to the Cinema Booking App!"
      redirect_to root_url
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private

    def user_params
      params.require(:user).permit(:full_name, :email, :mobile_number,
                                   :password, :password_confirmation)
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url, status: :see_other) unless current_user?(@user)
    end
end
