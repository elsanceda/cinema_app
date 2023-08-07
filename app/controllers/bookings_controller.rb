class BookingsController < ApplicationController
    before_action :logged_in_user, only: [:new, :create, :destroy]
    before_action :correct_user,   only: [:destroy]

    def show
        @booking = Booking.find(params[:id])
    end

    def new
        @booking = Booking.new
        @showings = Showing.all
        @free_seats = (1..10).to_a
    end

    def create
        @booking = Booking.new(booking_params)
        if @booking.save
            flash[:success] = "Booking created"
            redirect_to @booking
        else
            render 'new', status: :unprocessable_entity
        end
    end

    def destroy
        Booking.find(params[:id]).destroy
        flash[:success] = "Booking deleted"
        redirect_to admin_url
    end

    private

        def booking_params
            params.require(:booking).permit(:seat_number, :user_id, :showing_id)
        end

        def correct_user
            @booking = current_user.bookings.find_by(id: params[:id])
            redirect_to(root_url, status: :see_other) if @booking.nil?
        end

end
