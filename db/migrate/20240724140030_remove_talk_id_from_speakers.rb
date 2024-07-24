class RemoveTalkIdFromSpeakers < ActiveRecord::Migration[7.1]
  def change
    remove_reference :speakers, :talk, null: false, foreign_key: true
  end
end
