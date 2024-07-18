class Event < ApplicationRecord
  has_many :talks
  validates :name, :description, :local, :start_date, :end_date, presence: true
end
