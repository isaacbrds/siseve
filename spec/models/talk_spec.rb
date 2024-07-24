require 'rails_helper'

RSpec.describe Talk, type: :model do
  context 'validations' do
    it 'is valid with valid attributes' do
      user = User.create(
        name: 'João',
        email: 'joao@example.com',
        password: 'password'
      )

      event = Event.create(
        name: 'Ruby Conference',
        description: 'A conference about Ruby',
        local: 'São Paulo',
        start_date: DateTime.new(2024, 7, 20, 9, 0, 0),
        end_date: DateTime.new(2024, 7, 20, 18, 0, 0)
      )
      
      speaker = Speaker.create(
        user: user
      )

      talk = Talk.new(
        name: 'Introduction to Ruby',
        description: 'An introductory talk about Ruby programming language',
        start_date: DateTime.new(2024, 7, 20, 10, 0, 0),
        end_date: DateTime.new(2024, 7, 20, 11, 0, 0),
        event: event,
        speaker: speaker
      )
      expect(talk).to be_valid
    end

    it 'is not valid without a name' do
      talk = Talk.new(name: nil)
      expect(talk).to_not be_valid
    end

    it 'is not valid without a description' do
      talk = Talk.new(description: nil)
      expect(talk).to_not be_valid
    end

    it 'is not valid without a start_date' do
      talk = Talk.new(start_date: nil)
      expect(talk).to_not be_valid
    end

    it 'is not valid without a end_date' do
      talk = Talk.new(end_date: nil)
      expect(talk).to_not be_valid
    end

    it 'is not valid if end_date is before start_date' do
      talk = Talk.new(
        start_date: DateTime.new(2024, 7, 20, 10, 0, 0),
        end_date: DateTime.new(2024, 7, 20, 9, 0, 0)
      )
      expect(talk).to_not be_valid
    end
  end

  context 'associations' do
    it 'belongs to event' do
      association = described_class.reflect_on_association(:event)
      expect(association.macro).to eq :belongs_to
    end

    it 'has many speakers' do
      association = described_class.reflect_on_association(:speaker)
      expect(association.macro).to eq :belongs_to
    end
  end
end
