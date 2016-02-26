class CreatePlanes < ActiveRecord::Migration
  def change
    create_table :planes do |t|
      t.string  :category, :null => false #plane or helicopter
      t.integer  :passenger_capacity
      t.integer  :crew
      t.integer  :range
      t.integer  :full_pay_load_speed
      t.string  :base
      t.integer :service_sealing
      t.string  :cabin_dimensions

      t.timestamps null: false
    end
  end
end