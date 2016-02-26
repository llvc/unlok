class CreateSpecificationCategories < ActiveRecord::Migration
  def change
    create_table :specification_categories do |t|
      t.string :name, :null => false, :default => ""

      t.timestamps null: false
    end
  end
end
