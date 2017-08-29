class AddLongitudToSeguimientos < ActiveRecord::Migration
  def change
    	add_column :seguimientos, :longitud, :string
  end
end
