class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.boolean :active
      t.boolean :published

      t.timestamps
    end
  end
end
