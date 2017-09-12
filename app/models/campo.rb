class Campo < ActiveRecord::Base
   belongs_to :persona
   has_many :cuartele, dependent: :destroy
end
