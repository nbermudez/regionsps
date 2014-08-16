class AddIdFieldToTagCategorization < ActiveRecord::Migration
  def change
    add_column :tag_categorizations, :id, :primary_key
  end
end
