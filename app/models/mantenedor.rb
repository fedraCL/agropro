class Mantenedor < ActiveRecord::Base
  def self.navieras
    Mantenedor.where(:tipo => :naviera).order(:id)
  end
  def self.tipo_personas
    Mantenedor.where(:tipo => :tipo_persona).order(:id)
  end
  
  def self.paises
    Mantenedor.where(:tipo => :pais).order(:id)
  end
end
