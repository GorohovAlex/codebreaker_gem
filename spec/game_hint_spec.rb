module Codebreaker
  RSpec.describe Game do
    let(:codebreaker) { described_class.new }
    let(:hints) { [1, 2, 3, 4] }
    let(:game_stage) { GameStage.new(match_code_length: 4, attempts: 10) }

    context 'when get hint' do
      before do
        codebreaker.instance_variable_set(:@game_stage, game_stage)
        codebreaker.instance_variable_set(:@hint_code, hints)
      end

      it 'hint exists' do
        expect(codebreaker.hint_show).to eq(1)
      end

      it 'hints will less' do
        codebreaker.hint_show
        expect(hints).to eq([2, 3, 4])
      end
    end
  end
end
