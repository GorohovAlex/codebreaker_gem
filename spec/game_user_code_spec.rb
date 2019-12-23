module Codebreaker
  RSpec.describe Game do
    let(:codebreaker) { described_class.new }

    context 'when input match_code' do
      it 'input valid match_code' do
        codebreaker.send(:match_code_valid?, [1, 2, 3, 4])
        expect(codebreaker.errors[:match_code]).to eq(nil)
      end

      it 'input not valid match_code length' do
        codebreaker.send(:match_code_valid?, [1, 2, 3])
        expect(codebreaker.errors[:match_code]).to eq('error_match_code_length')
      end

      it 'input not valid match_code range' do
        codebreaker.send(:match_code_valid?, [0, 2, 3, 3])
        expect(codebreaker.errors[:match_code]).to eq('error_match_code_number')
      end
    end
  end
end
