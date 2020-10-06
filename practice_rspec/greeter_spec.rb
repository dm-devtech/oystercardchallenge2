require './greeter'
describe 'Greeter' do
    it 'greets Chloe' do
      expect(greet('Chloe')).to eq 'Hello, Chloe, how are you today?'
    end
  end