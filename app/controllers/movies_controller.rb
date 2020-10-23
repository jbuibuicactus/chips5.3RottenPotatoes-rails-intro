class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @movies = Movie.all
    @all_ratings = Movie.all_ratings
    
    puts params
    puts session
    
    atagselection = params[:selected]==nil ? session[:selected] : params[:selected]
    
    if params[:rating] != nil
      ratingslist = params[:ratings].keys
    elsif session[:ratings] != nil
      ratingslist = session[:ratings]
    else
      ratingslist = []
    end
=begin
    if !(session[:ratings]== nil)
      ratingslist = session[:ratings]
    elsif params[:ratings] == nil
      ratingslist = []
    else
      ratingslist = params[:ratings].keys
    end
=end
    @ratings_to_show = ratingslist
    session[:ratings] = ratingslist
    @movies = Movie.with_ratings(ratingslist)
    holder = @movies
    
    if atagselection == "Title" || atagselection == "Release_Date"
      @sort = atagselection
      session[:selected] = atagselection
      orderstr = atagselection.downcase
      @movies = holder.order(orderstr)
    end 
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

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
