class MoviesController < ApplicationController

  def show
    @movie = Movie.find(params[:id])
    puts "@movie.title: #{@movie.title}"
  end
  

  def index
    @movies = Movie.all
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def find_movies_with_same_director
    @movie = Movie.find(params[:id])
    puts 'i am in control'
    if @movie.director.blank?
      flash[:notice] = "'#{@movie.title}' has no director info."
      redirect_to root_path
    else
      @movies_with_same_director = Movie.where(director: @movie.director)
  
      if @movies_with_same_director.any?
        redirect_to edit_movie_path(@movies_with_same_director.first)
      end
    end
  end
  

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date, :director)
  end
end

