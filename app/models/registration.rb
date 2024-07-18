class Registration < ApplicationRecord
  belongs_to :user
  belongs_to :event

  enum status: [:pendente, :inscrito, :participada]
  validates :status, presence: true
end
