require 'oystercard.rb'
describe Oystercard do
    it 'checks the balance in the card' do
    expect{ subject.top_up 5}.to change{subject.balance }.by 5
    end

    # it 'checks the top up method' do
    # expect(subject.top_up(5)).to eq 5
    # end
    it { is_expected.to respond_to(:top_up).with(1).argument }

end