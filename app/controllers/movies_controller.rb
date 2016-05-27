class MoviesController < ApplicationController


  def index

    @movies = Movie.all
    @movies = @movies.director_search(params[:director]) if params[:director].present?
    @movies = @movies.title_search(params[:title]) if params[:title].present?
    @prev_choice = params[:runtime] if params[:runtime]
    @movies = @movies.under_90 if params[:runtime] == "a"
    @movies = @movies.between_90_and_120 if params[:runtime] == "b"
    @movies = @movies.over_120 if params[:runtime] == "c"
    # if params[:runtime].present?
    #   case params[:runtime]
    #   when "a"
    #    @movies = Movie.under_90
    #   when "b"
    #    @movies = Movie.between_90_and_120
    #   when "c"
    #    @movies = Movie.over_120
    #   end
    # end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was added to the list of movies!"
    else
      render :new
    end
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update_attributes(movie_params)
      redirect_to movies_path, notice: "#{@movie.title} has been updated!"
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end


  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :poster_image_url, :description, :image
      )
  end

end
