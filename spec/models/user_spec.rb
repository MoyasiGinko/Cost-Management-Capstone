require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'User model' do
    subject { User.new(name: 'anuar', email: 'ra@example.com', password: '123456') }
    before { subject.save }

    it 'check the name is  blank' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'check the email is not blank' do
      subject.email = nil
      expect(subject).to_not be_valid
    end
  end
end
