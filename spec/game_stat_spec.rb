module Codebreaker
  RSpec.describe Game do
    let(:codebreaker) { described_class.new }
    let(:difficulty) { Difficulty.new(name: 'Easy', attempts: 15, hints: 3, level: 0) }
    let(:game_stage) { GameStage.new(attempts: 10) }
    let(:user) { instance_double('User', username: 'Smile') }
    let(:statistic) { Statistic.new }
    let(:test_file) { 'statistic_test.yml' }

    context 'when statistic save' do
      before do
        stub_const('Codebreaker::Statistic::STAT_FILE_PATH', test_file)
        codebreaker.instance_variable_set(:@user, user)
        codebreaker.instance_variable_set(:@statistic, statistic)
        codebreaker.instance_variable_set(:@difficulty, difficulty)
        codebreaker.instance_variable_set(:@game_stage, game_stage)
      end

      it 'success statistic save' do
        codebreaker.statistic_save
        expect(codebreaker.statistic.statistic_get).to eq([[1, 'Smile', 'Easy', 10, 0, 3, 0]])
      end
    end
  end
end
