module Codebreaker
  RSpec.describe CodebreakerGem do
    let(:codebreaker_gem) { described_class.new }

    context 'when input user_code' do
      it 'input valid user_code' do
        codebreaker_gem.user_code = [1, 2, 3, 4]
        expect(codebreaker_gem.user_code).to eq([1, 2, 3, 4])
      end

      it 'input not valid user_code length' do
        codebreaker_gem.user_code = [1, 2, 3]
        expect(codebreaker_gem.errors[:user_code]).to eq('error_user_code_length')
      end
    end
  end
end
