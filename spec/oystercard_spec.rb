require 'oystercard.rb'
describe Oystercard do
  it 'checks that the oystercard has an initial value of 0' do
    expect(subject.balance).to eq 0
    end
  
  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'checks the increase balance in the card' do
    expect{ subject.top_up 5}.to change{subject.balance }.by 5
    end
    
    it 'raises error when trying to top up to be more than £90' do
        expect { subject.top_up 91 }.to raise_error('You cannot have more than £90 in your balance')
      end
    
  end

  describe '#deduct' do
    it 'checks out the deducted amount' do
    expect(subject).to respond_to(:deduct)
    end

    it { is_expected.to respond_to(:deduct).with(1).argument }

    it 'checks that the amount to deduct is effectively deducted from the balance' do
    expect {subject.deduct 10 }.to change{subject.balance }.by -10
    end

  end


end