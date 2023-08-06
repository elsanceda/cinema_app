class MoviesController < ApplicationController
    before_action :logged_in_user,  only: [:new, :create, :edit, :update, :destroy]
    before_action :admin_user,      only: [:new, :create, :edit, :update, :destroy]

    def index
        @movies = Movie.paginate(page: params[:page])
    end

    def show
        @movie = Movie.find(params[:id])
        # TODO: show movie showings
    end

    def new
        @movie = Movie.new
    end

    def create
      @movie = Movie.new(movie_params)
      if @movie.save
        flash[:success] = "Movie created"
        redirect_to root_url # TODO: redirect to admin dashboard
      else
        render 'new', status: :unprocessable_entity
      end
    end

    def edit
        @movie = Movie.find(params[:id])
    end

    def update
        if @movie.update(movie_params)
            flash[:success] = "Movie updated"
            redirect_to @movie
        else
            render 'edit', status: :unprocessable_entity
        end
    end

    def destroy
        @movie.destroy
        flash[:success] = "Movie deleted"
        redirect_to root_url # TODO: redirect to admin dashboard
    end

    private

        def movie_params
            params.require(:movie).permit(:name, :synopsis)
        end
end
