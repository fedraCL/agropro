class CreateSeguimientoHistorials < ActiveRecord::Migration
  def change
    create_table :seguimiento_historials do |t|
      t.integer :id_origen
      t.string :codigo
      t.string :naviera
      t.string :nave
      t.string :pol
      t.string :pod
      t.string :etd
      t.string :eta
      t.integer :countchange
      t.string :user

      t.timestamps
    end
  end
end
