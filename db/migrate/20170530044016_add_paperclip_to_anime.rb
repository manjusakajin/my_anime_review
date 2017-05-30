class AddPaperclipToAnime < ActiveRecord::Migration[5.0]
  def up
    add_attachment :animes, :image
  end

  def down
    remove_attachment :animes, :image
  end
end
