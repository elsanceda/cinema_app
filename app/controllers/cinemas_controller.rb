class CinemasController < ApplicationController
    before_action :logged_in_user,  only: [:new, :create, :edit, :update, :destroy]
    before_action :admin_user,      only: [:new, :create, :edit, :update, :destroy]

    def index
        @cinemas = Cinema.paginate(page: params[:page])
    end

    def show
        @cinema = Cinema.find(params[:id])
        @cinema_showings = @cinema.cinema_showings.paginate(page: params[:page])
    end

    def new
        @cinema = Cinema.new
    end

    def create
      @cinema = Cinema.new(cinema_params)
      if @cinema.save
        flash[:success] = "Cinema created"
        redirect_to @cinema
      else
        render 'new', status: :unprocessable_entity
      end
    end

    def edit
        @cinema = Cinema.find(params[:id])
    end

    def update
        @cinema = Cinema.find(params[:id])
        if @cinema.update(cinema_params)
            flash[:success] = "Cinema updated"
            redirect_to @cinema
        else
            render 'edit', status: :unprocessable_entity
        end
    end

    def destroy
        Cinema.find(params[:id]).destroy
        flash[:success] = "Cinema deleted"
        redirect_to admin_url # TODO: redirect to admin dashboard
    end

    private

        def cinema_params
            params.require(:cinema).permit(:name, :location, :seats)
        end
end
