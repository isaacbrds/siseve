require 'rails_helper'

RSpec.describe Speaker, type: :model do
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

    talk = Talk.create(
      name: 'Introduction to Ruby',
      description: 'An introductory talk about Ruby programming language',
      start_date: DateTime.new(2024, 7, 20, 10, 0, 0),
      end_date: DateTime.new(2024, 7, 20, 11, 0, 0),
      event: event
    )

    speaker = Speaker.new(
      user: user,
      talk: talk
    )
    
    expect(speaker).to be_valid
  end

  it 'is not valid without a user' do
    talk = Talk.create(
      name: 'Advanced Ruby',
      description: 'A talk about advanced Ruby features',
      start_date: DateTime.new(2024, 7, 20, 14, 0, 0),
      end_date: DateTime.new(2024, 7, 20, 15, 0, 0)
    )

    speaker = Speaker.new( user: nil, talk: talk)
    expect(speaker).to_not be_valid
  end

  it 'is not valid without a talk' do
    user = User.create(
      name: 'Ana',
      email: 'ana@example.com',
      password: 'password'
    )

    speaker = Speaker.new(user: user, talk: nil)
    expect(speaker).to_not be_valid
  end

  context 'associations' do
    it 'belongs to user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end

    it 'belongs to talk' do
      association = described_class.reflect_on_association(:talk)
      expect(association.macro).to eq :belongs_to
    end
  end
end
