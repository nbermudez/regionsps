class AddArticleIdToResource < ActiveRecord::Migration
  def change
    add_column :resources, :article_id, :integer
  end
end
