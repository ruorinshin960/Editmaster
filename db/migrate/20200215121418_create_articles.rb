class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.text :title
      t.text :text
      t.string :image
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
