RSpec.describe User do
  context 'when User.new' do
    it 'with normal username' do
      user = User.new('Smile')
      expect(user.username).to eq('Smile')
    end

    it 'with empty username' do
      user = User.new('')
      expect(user.valid?).to eq(false)
    end

    it 'with long username' do
      user = User.new('s' * USERNAME_LENGTH_RANGE.max.next)
      expect(user.valid?).to eq(false)
    end

    it 'with short username' do
      user = User.new('s' * USERNAME_LENGTH_RANGE.min.pred)
      expect(user.valid?).to eq(false)
    end
  end
end
