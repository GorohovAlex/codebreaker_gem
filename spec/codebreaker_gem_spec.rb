module Codebreaker
  RSpec.describe CodebreakerGem do
    let(:codebreaker_gem) { CodebreakerGem.new }

    context 'when register user' do
      it 'valid username' do
        username_valid = { status: true, value: 'Smile' }
        username_test = codebreaker_gem.registration('Smile')
        expect(username_test).to eq(username_valid)
      end

      it 'not valid username length short' do
        username_valid = { status: false, value: 'a' * USERNAME_LENGTH_RANGE.min.pred }
        username_test = codebreaker_gem.registration('a' * USERNAME_LENGTH_RANGE.min.pred)
        expect(username_test).to eq(username_valid)
      end

      it 'not valid username length more' do
        username_valid = { status: false, value: 'a' * USERNAME_LENGTH_RANGE.max.next }
        username_test = codebreaker_gem.registration('a' * USERNAME_LENGTH_RANGE.max.next)
        expect(username_test).to eq(username_valid)
      end
    end

    context 'when input user_code' do
      it 'input valid user_code' do
        codebreaker_gem.user_code = [1, 2, 3, 4]
        expect(codebreaker_gem.user_code).to eq([1, 2, 3, 4])
      end

      it 'input not valid user_code length' do
        codebreaker_gem.user_code = [1, 2, 3]
        expect(codebreaker_gem.errors[:user_code]).to eq('error_code_length')
      end

      # it 'input not valid user_code number' do
      #   codebreaker_gem.user_code = [1, 2, -10, 1]
      #   expect(codebreaker_gem.errors[:user_code]).to eq('error_code_number')
      # end
    end

    context 'when change difficulty' do
      it 'set difficulty' do
      codebreaker_gem.difficulty_change = 'Easy'
      expect(codebreaker_gem.difficulty_change.name).to eq('Easy')
      end
    end

    context 'compare code' do
      before do
        codebreaker_gem.difficulty_change = 'Easy'
      end

      it 'verificate code' do
        [
          [[6, 5, 4, 1], [6, 5, 4, 1], [true, true, true, true]],
          [[1, 2, 2, 1], [2, 1, 1, 2], [false, false, false, false]],
          [[6, 2, 3, 5], [2, 3, 6, 5], [true, false, false, false]],
          [[1, 2, 3, 4], [4, 3, 2, 1], [false, false, false, false]],
          [[1, 2, 3, 4], [1, 2, 3, 5], [true, true, true]], [[1, 2, 3, 4], [5, 4, 3, 1], [true, false, false]],
          [[1, 2, 3, 4], [1, 5, 2, 4], [true, true, false]], [[1, 2, 3, 4], [4, 3, 2, 6], [false, false, false]],
          [[1, 2, 3, 4], [3, 5, 2, 5], [false, false]], [[1, 2, 3, 4], [5, 6, 1, 2], [false, false]],
          [[5, 5, 6, 6], [5, 6, 0, 0], [true, false]], [[1, 2, 3, 4], [6, 2, 5, 4], [true, true]],
          [[1, 2, 3, 1], [1, 1, 1, 1], [true, true]], [[1, 1, 1, 5], [1, 2, 3, 1], [true, false]],
          [[1, 2, 3, 4], [4, 2, 5, 5], [true, false]], [[1, 2, 3, 4], [5, 6, 3, 5], [true]],
          [[1, 2, 3, 4], [6, 6, 6, 6], []], [[1, 2, 3, 4], [2, 5, 5, 2], [false]]
        ].each do |item|
          allow(codebreaker_gem).to receive(:generate_number) { item[0] }
          codebreaker_gem.game_start
          codebreaker_gem.user_code = item[1]
          codebreaker_gem.game_step
          expect(codebreaker_gem.game_stage.compare_result).to eq(item[2])
        end
      end
    end
  end
end
