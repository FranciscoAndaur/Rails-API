class CreateNfts < ActiveRecord::Migration[6.1]
  def change
    create_table :nfts do |t|
      t.string :name
      t.integer :year
      t.integer :price
      t.string :description
      t.string :posted_url
      t.string :category
      t.boolean :sale
      t.boolean :rarity

      t.timestamps
    end
  end
end
