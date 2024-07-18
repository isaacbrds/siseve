class Talk < ApplicationRecord
  belongs_to :event
  validates :name, :description, :start_date, :end_date, presence: true
end
