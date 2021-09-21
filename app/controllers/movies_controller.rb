class MoviesController < ApplicationController
  def index
    @movies = Movie.order(year: :desc)

    if params[:query].present?
      @movies = @movies.where('title ILIKE ?', "%#{params[:query]}%")
    end

    # render the partial of card lists for our stimulus search
    respond_to do |format|
      format.html
      format.text { render partial: 'movies/list', locals: { movies: @movies }, formats: [:html] }
    end
  end

  def update
    @movie = Movie.find(params[:id])
    @movie.update(movie_params)

    # if it's html, redirect normally
    # if it's text, render our movie_info partial with the new data

    respond_to do |format|
      format.html { redirect_to movies_path }
      format.text { render partial: 'movies/movie_infos', locals: { movie: @movie }, formats: [:html] }
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :year)
  end
end
