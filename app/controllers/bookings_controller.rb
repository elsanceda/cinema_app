class BookingsController < ApplicationController
    before_action :logged_in_user, only: [:new, :create, :destroy]
    before_action :correct_user,   only: [:destroy]

    def new
        @booking = Booking.new
        @showing = Showing.find(params[:showing_id])
        @seats = @showing.available_seats
    end

    def create
        @booking = current_user.bookings.build(booking_params)
        if @booking.save
            flash[:success] = "Booking made"
            redirect_to current_user
        else
            @showing = Showing.find(params[:showing_id])
            @seats = @showing.available_seats
            render 'new', status: :unprocessable_entity
        end
    end

    def destroy
        Booking.find(params[:id]).destroy
        flash[:success] = "Booking cancelled"
        redirect_to current_user
    end

    private

        def booking_params
            params.require(:booking).permit(:seat_number, :showing_id)
        end

        def correct_user
            @booking = current_user.bookings.find_by(id: params[:id])
            redirect_to(root_url, status: :see_other) if @booking.nil?
        end
end
