class Persona < ActiveRecord::Base
  has_many :campos, dependent: :destroy
end
