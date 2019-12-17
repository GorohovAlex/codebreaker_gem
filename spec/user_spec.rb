module Codebreaker
RSpec.describe User do
  context 'when User.new' do
    let(:user) { described_class.new('Smile') }

    it 'with normal username' do
      expect(user.username).to eq('Smile')
    end
  end

  context 'when User.new' do
    let(:user) { described_class.new('') }

    it 'with empty username' do
      expect(user.valid?).to eq(false)
    end
  end

  context 'when User.new' do
    let(:user) { described_class.new('s' * User::USERNAME_LENGTH_RANGE.max.next) }

    it 'with long username' do
      expect(user.valid?).to eq(false)
    end
  end

  context 'when User.new' do
    let(:user) { described_class.new('s' * User::USERNAME_LENGTH_RANGE.min.pred) }

    it 'with short username' do
      expect(user.valid?).to eq(false)
    end
  end
end
end