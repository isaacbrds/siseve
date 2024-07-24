class Speaker < ApplicationRecord
  belongs_to :user
  has_many :talks
end
