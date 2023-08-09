class ShowingsController < ApplicationController
    before_action :logged_in_user,  only: [:new, :create, :destroy]
    before_action :admin_user,      only: [:new, :create, :destroy]

    def index
        @showings = Showing.paginate(page: params[:page])
    end

    def show
        @showing = Showing.find(params[:id])
    end

    def new
        @showing = Showing.new
        @cinemas = Cinema.all
        @movies = Movie.all
        @timeslots = [600, 840, 1080, 1320]
    end

    def create
        @showing = Showing.new(showing_params)
        if @showing.save
            flash[:success] = "Showing created"
            redirect_to @showing
        else
            @cinemas = Cinema.all
            @movies = Movie.all
            @timeslots = [600, 840, 1080, 1320]
            render 'new', status: :unprocessable_entity
        end
    end

    def destroy
        Showing.find(params[:id]).destroy
        flash[:success] = "Showing deleted"
        redirect_to root_url
    end

    # Returns list of available timeslots
    def free_timeslots
        timeslots = [600, 840, 1080, 1320]
        other_showings = Showing.where(cinema_id: params[:cinema_id]).pluck(:timeslot)
        @free_timeslots = timeslots.reject { |timeslot| other_showings.include?(timeslot) }
        @target = params[:target]
        respond_to do |format|
            format.turbo_stream
        end
    end

    def bookings
        @showing  = Showing.find(params[:id])
        @title = "Bookings | #{@showing.movie.title}"
        @bookings = @showing.bookings.paginate(page: params[:page])
        render 'showing_booking', status: :unprocessable_entity
    end

    private

        def showing_params
            params.require(:showing).permit(:timeslot, :cinema_id, :movie_id)
        end
end
