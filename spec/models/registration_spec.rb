require 'rails_helper'

RSpec.describe Registration, type: :model do
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

      registration = Registration.new(user: user, event: event)
      expect(registration).to be_valid
    end

    it 'is not valid without a user' do
      event = Event.create(
        name: 'Ruby Conference',
        description: 'A conference about Ruby',
        local: 'São Paulo',
        start_date: DateTime.new(2024, 7, 20, 9, 0, 0),
        end_date: DateTime.new(2024, 7, 20, 18, 0, 0)
      )

      registration = Registration.new(user: nil, event: event)
      expect(registration).to_not be_valid
    end

    it 'is not valid without an event' do
      user = User.create(
        name: 'João',
        email: 'joao@example.com',
        password: 'password'
      )

      registration = Registration.new(user: user, event: nil)
      expect(registration).to_not be_valid
    end
  end

  context 'associations' do
    it 'belongs to user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end

    it 'belongs to event' do
      association = described_class.reflect_on_association(:event)
      expect(association.macro).to eq :belongs_to
    end
  end
end
