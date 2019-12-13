RSpec.describe BaseClass do
  let(:current_entity) { BaseClass.new }

  context 'when validation' do
    it 'base valid?' do
      expect { current_entity.valid? }.to raise_error(NotImplementedError)
    end
  end
end
