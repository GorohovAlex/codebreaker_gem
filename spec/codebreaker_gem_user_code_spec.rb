module Codebreaker
  RSpec.describe CodebreakerGem do
    let(:codebreaker) { described_class.new }

    context 'when input user_code' do
      it 'input valid user_code' do
        codebreaker.send(:user_code_valid?, [1, 2, 3, 4])
        expect(codebreaker.errors[:user_code]).to eq(nil)
      end

      it 'input not valid user_code length' do
        codebreaker.send(:user_code_valid?, [1, 2, 3])
        expect(codebreaker.errors[:user_code]).to eq('error_user_code_length')
      end

      it 'input not valid user_code range' do
        codebreaker.send(:user_code_valid?, [0, 2, 3, 3])
        expect(codebreaker.errors[:user_code]).to eq('error_user_code_number')
      end
    end
  end
end
