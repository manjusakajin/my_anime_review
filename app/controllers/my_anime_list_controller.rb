class MyAnimeListController < ApplicationController
  def show
    if valid_page?
      if params[:page] == "home"
        @animes = Anime.all.order(created_at: :desc)
          .paginate page: params[:page_number], per_page: Settings.home_perpage
        @reviews = Review.all.order(created_at: :desc)
          .paginate page: params[:page_number], per_page: Settings.home_perpage
      end
      render template: "my_anime_list/#{params[:page]}"
    else
      render file: "public/404.html", status: :not_found
    end
  end

  private

  def valid_page?
    File.exist?(Pathname.new(Rails.root +
      "app/views/my_anime_list/#{params[:page]}.html.erb"))
  end
end
