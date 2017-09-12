class AddReferencesToPersonas < ActiveRecord::Migration
  def change
    add_reference :personas, :campo, index: true
  end
end
