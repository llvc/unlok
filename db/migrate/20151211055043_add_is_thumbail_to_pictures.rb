class AddIsThumbailToPictures < ActiveRecord::Migration
  def change
    add_column :pictures, :is_thumbnail, :boolean
  end
end
