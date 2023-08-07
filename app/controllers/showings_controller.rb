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
        @free_timeslots = [600, 840, 1080, 1320]
    end

    def create
        @showing = Showing.new(showing_params)
        if @showing.save
            flash[:success] = "Showing created"
            redirect_to @showing
        else
            render 'new', status: :unprocessable_entity
        end
    end

    def destroy
        Showing.find(params[:id]).destroy
        flash[:success] = "Showing deleted"
        redirect_to admin_url
    end

    # Returns list of available timeslots
    # def get_free_timeslots
    #     timeslots = [600, 840, 1080, 1320]
    #     other_showings = Showing.where(cinema_id: params[:cinema_id]).pluck(:timeslot)
    #     @free_timeslots = timeslots.reject { |timeslot| other_showings.include?(timeslot) }
    # end

    private

        def showing_params
            params.require(:showing).permit(:timeslot, :cinema_id, :movie_id)
        end
end
