require 'rails_helper'

RSpec.describe Event, type: :model do
  context 'validations' do
    it 'is valid with valid attributes' do
      event = Event.new(
        name: 'Ruby Conference',
        description: 'A conference about Ruby',
        local: 'São Paulo',
        start_date: DateTime.new(2024, 7, 20, 9, 0, 0),
        end_date: DateTime.new(2024, 7, 20, 18, 0, 0)
      )
      expect(event).to be_valid
    end

    it 'is not valid without a name' do
      event = Event.new(
        name: nil,
        description: 'A conference about Ruby',
        local: 'São Paulo',
        start_date: DateTime.new(2024, 7, 20, 9, 0, 0),
        end_date: DateTime.new(2024, 7, 20, 18, 0, 0)
      )
      expect(event).to_not be_valid
    end

    it 'is not valid without a description' do
      event = Event.new(
        name: 'Ruby Conference',
        description: nil,
        local: 'São Paulo',
        start_date: DateTime.new(2024, 7, 20, 9, 0, 0),
        end_date: DateTime.new(2024, 7, 20, 18, 0, 0)
      )
      expect(event).to_not be_valid
    end

    it 'is not valid without a local' do
      event = Event.new(
        name: 'Ruby Conference',
        description: 'A conference about Ruby',
        local: nil,
        start_date: DateTime.new(2024, 7, 20, 9, 0, 0),
        end_date: DateTime.new(2024, 7, 20, 18, 0, 0)
      )
      expect(event).to_not be_valid
    end

    it 'is not valid without a start_date' do
      event = Event.new(
        name: 'Ruby Conference',
        description: 'A conference about Ruby',
        local: 'São Paulo',
        start_date: nil,
        end_date: DateTime.new(2024, 7, 20, 18, 0, 0)
      )
      expect(event).to_not be_valid
    end

    it 'is not valid without a end_date' do
      event = Event.new(
        name: 'Ruby Conference',
        description: 'A conference about Ruby',
        local: 'São Paulo',
        start_date: DateTime.new(2024, 7, 20, 9, 0, 0),
        end_date: nil
      )
      expect(event).to_not be_valid
    end
  end

  context 'associations' do
    it 'has many talks' do
      association = described_class.reflect_on_association(:talks)
      expect(association.macro).to eq :has_many
    end
  end
end
