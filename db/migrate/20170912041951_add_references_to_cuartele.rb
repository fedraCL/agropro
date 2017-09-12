class AddReferencesToCuartele < ActiveRecord::Migration
  def change
    add_reference :cuarteles, :campo, index: true
  end
end
