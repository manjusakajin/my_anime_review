class CreateRates < ActiveRecord::Migration[5.0]
  def change
    create_table :rates do |t|
      t.integer :user_id
      t.integer :anime_id
      t.float :rating

      t.timestamps
    end
  end
end
