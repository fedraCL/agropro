class CreatePersonas < ActiveRecord::Migration
  def change
    create_table :personas do |t|
      t.string :rut
      t.string :dv
      t.string :tipo
      t.string :estado
      t.string :razonsocial
      t.string :alias
      t.string :nacionalidad
      t.string :direccion
      t.string :email
      t.string :contacto
      t.string :user

      t.timestamps
    end
  end
end
