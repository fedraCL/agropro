class AddLatitudToSeguimientos < ActiveRecord::Migration
  def change
  	add_column :seguimientos, :latitud, :string
  end
  
end
