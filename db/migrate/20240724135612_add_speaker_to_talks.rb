class AddSpeakerToTalks < ActiveRecord::Migration[7.1]
  def change
    add_reference :talks, :speaker, null: false, foreign_key: true
  end
end
