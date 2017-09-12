class CreateCuarteles < ActiveRecord::Migration
  def change
    create_table :cuarteles do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
