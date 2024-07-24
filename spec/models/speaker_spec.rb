require 'rails_helper'

RSpec.describe Speaker, type: :model do
  it 'is valid with valid attributes' do
    user = User.create(
      name: 'João',
      email: 'joao@example.com',
      password: 'password'
    )

   
    speaker = Speaker.new(
      user: user
    )
    
    expect(speaker).to be_valid
  end

  it 'is not valid without a user' do
    speaker = Speaker.new( user: nil)
    expect(speaker).to_not be_valid
  end

  context 'associations' do
    it 'belongs to user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end
  end
end
