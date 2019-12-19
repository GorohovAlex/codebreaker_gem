module Codebreaker
  RSpec.describe CodebreakerGem do
    let(:codebreaker) { described_class.new }

    context 'when register user' do
      it 'valid username' do
        username_valid = { status: true, value: 'Smile' }
        username_test = codebreaker.registration('Smile')
        expect(username_test).to eq(username_valid)
      end

      it 'not valid username length short' do
        username_test = codebreaker.registration('a' * User::USERNAME_LENGTH_RANGE.min.pred)
        expect(username_test[:status]).to eq(false)
      end

      it 'not valid username length more' do
        username_test = codebreaker.registration('a' * User::USERNAME_LENGTH_RANGE.max.next)
        expect(username_test[:status]).to eq(false)
      end
    end

    context 'when change difficulty' do
      it 'set difficulty' do
        codebreaker.difficulty_change = 'Easy'
        expect(codebreaker.difficulty_change.name).to eq('Easy')
      end
    end
  end
end
