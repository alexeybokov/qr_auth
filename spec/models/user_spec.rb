require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create :valid_user }

  it 'is an instance of User' do
    expect(subject).to be_an User
  end

  it 'is invalid without an email' do
    expect(build(:user_without_email)).not_to be_valid
  end

  it 'does not allow duplicate emails' do
    user
    new_user = User.new(email: user.email, password: Faker::Internet.password)
    new_user.valid?
    expect(new_user.errors.any?).to be true
  end
end
