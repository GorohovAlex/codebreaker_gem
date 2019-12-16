module Codebreaker
  RSpec.describe CodebreakerGem do
    let(:codebreaker_gem) { described_class.new }

    context 'when compare code' do
      before { codebreaker_gem.difficulty_change = 'Easy' }

      [
        { user_code: [6, 5, 4, 1], secret_code: [6, 5, 4, 1], result: [true, true, true, true] },
        { user_code: [1, 2, 2, 1], secret_code: [2, 1, 1, 2], result: [false, false, false, false] },
        { user_code: [6, 2, 3, 5], secret_code: [2, 3, 6, 5], result: [true, false, false, false] },
        { user_code: [1, 2, 3, 4], secret_code: [4, 3, 2, 1], result: [false, false, false, false] },
        { user_code: [1, 2, 3, 4], secret_code: [1, 2, 3, 5], result: [true, true, true] },
        { user_code: [1, 2, 3, 4], secret_code: [5, 4, 3, 1], result: [true, false, false] },
        { user_code: [1, 2, 3, 4], secret_code: [4, 3, 2, 6], result: [false, false, false] },
        { user_code: [1, 2, 3, 4], secret_code: [3, 5, 2, 5], result: [false, false] },
        { user_code: [1, 2, 3, 4], secret_code: [5, 6, 1, 2], result: [false, false] },
        { user_code: [5, 5, 6, 6], secret_code: [5, 6, 0, 0], result: [true, false] },
        { user_code: [1, 2, 3, 4], secret_code: [6, 2, 5, 4], result: [true, true] },
        { user_code: [1, 2, 3, 1], secret_code: [1, 1, 1, 1], result: [true, true] },
        { user_code: [1, 1, 1, 5], secret_code: [1, 2, 3, 1], result: [true, false] },
        { user_code: [1, 2, 3, 4], secret_code: [4, 2, 5, 5], result: [true, false] },
        { user_code: [1, 2, 3, 4], secret_code: [5, 6, 3, 5], result: [true] },
        { user_code: [1, 2, 3, 4], secret_code: [6, 6, 6, 6], result: [] },
        { user_code: [1, 2, 3, 4], secret_code: [2, 5, 5, 2], result: [false] }
      ].each do |item|
        user_code = item[:user_code]
        secret_code = item[:secret_code]
        expect_text = "responds with %s for user_code #{user_code.join} and secret_code #{secret_code.join}"

        it 'verificate code' do
          allow(codebreaker_gem).to receive(:generate_number) { secret_code }
          codebreaker_gem.game_start
          codebreaker_gem.user_code = user_code
          game_stage = codebreaker_gem.game_step
          expect(expect_text % game_stage.compare_result.join(', ')).to eq(expect_text % item[:result].join(', '))
        end
      end
    end
  end
end
