module Codebreaker
  RSpec.describe CodebreakerGem do
    let(:codebreaker) { described_class.new }
    let(:difficulty_change) { Difficulty.new(name: 'Easy', attempts: 15, hints: 2, level: 0) }
    let(:game_stage) { GameStage.new(user_code_length: 4, attempts: 10) }
    let(:user) { instance_double('User', username: 'Smile') }

    context 'when statistic save' do
      it 'success statistic save' do
        codebreaker.instance_variable_set(:@user, user)
        codebreaker.instance_variable_set(:@difficulty_change, difficulty_change)
        codebreaker.instance_variable_set(:@game_stage, game_stage)
        codebreaker.statistic_save
      end
    end
  end
end
