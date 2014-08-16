class AddPositionToTagCategorization < ActiveRecord::Migration
  def change
    add_column :tag_categorizations, :tag_position, :integer
  end
end
