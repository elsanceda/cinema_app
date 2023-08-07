class BookingsController < ApplicationController
    before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
    before_action :correct_user,   only: [:edit, :update, :destroy]

    private

        def booking_params
            params.require(:booking).permit(:seat_number, :user_id, :showing_id)
        end

        def correct_user
            @booking = current_user.bookings.find_by(id: params[:id])
            redirect_to(root_url, status: :see_other) if @booking.nil?
        end

end
