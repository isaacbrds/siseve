class Event < ApplicationRecord
  has_many :talks
  has_many :registrations
  has_many :registered_users, through: :registrations, source: :user
  
  validates :name, :description, :local, :start_date, :end_date, presence: true
end
