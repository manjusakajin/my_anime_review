class GenresController < ApplicationController
  def index
    @genres = Genre.all
  end

  def show
    @genre = Genre.find_by id: params[:id]
    if @genre
      @anime_genres = @genre.anime_genres
    else
      flash[:danger] = t "genre.not_found"
      redirect_to root_url
    end
  end
end
