class Talk < ApplicationRecord
  belongs_to :event
  belongs_to :speaker
  
  validates :name, :description, :start_date, :end_date, presence: true
end
