class Talk < ApplicationRecord
  belongs_to :event
  has_many :speakers
  
  validates :name, :description, :start_date, :end_date, presence: true
end
