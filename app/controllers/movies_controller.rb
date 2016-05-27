class MoviesController < ApplicationController


  def index
    @movies = Movie.all
    @movies = @movies.where("title LIKE ?", "%#{params[:title]}%") if params[:title].present?
    @movies = @movies.where("director LIKE ?", "%#{params[:director]}%") if params[:director].present?
    if params[:runtime]
      case params[:runtime]
      when "a"
       @movies = @movies.where("runtime_in_minutes < 90")
      when "b"
       @movies = @movies.where("runtime_in_minutes BETWEEN 90 AND 120")
      when "c"
       @movies = @movies.where("runtime_in_minutes > 90")
      end
    end
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

  def self.search(title, director, runtime)

  end

  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :poster_image_url, :description, :image
      )
  end

end
