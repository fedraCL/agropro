class AddReferencesToCampos < ActiveRecord::Migration
  def change
    add_reference :campos, :persona, index: true
  end
end
