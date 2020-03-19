class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.text :title, index: true
      t.text :text, index: true
      t.string :image
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
