require 'oystercard.rb'
describe Oystercard do
  it 'checks that the oystercard has an initial value of 0' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do

    it 'checks the increase balance in the card' do
      expect { subject.top_up Oystercard::MINIMUM_FARE }.to change {subject.balance }.by Oystercard::MINIMUM_FARE
    end

    context 'when topped up' do
      before do
        subject.top_up(Oystercard::BALANCE_LIMIT)
      end

      it 'raises error when trying to top up to be more than £90' do
        #maximum_limit = Oystercard::BALANCE_LIMIT
        #subject.top_up(Oystercard::BALANCE_LIMIT)
        expect { subject.top_up 1 }.to raise_error("Maximum balance is £#{Oystercard::BALANCE_LIMIT}.")
      end
    end
  end

  describe '#in_journey' do

    it 'checks in_journey is false by default' do
      expect(subject.in_journey?).to eq(false)
    end
  end

  describe '#touch_in' do

    it { is_expected.to respond_to(:touch_in).with(1).argument }

    it 'checks that touch in changes journey status to true' do
      subject.top_up(1)
      subject.touch_in
      expect(subject.in_journey?).to eq(true)
    end

    it 'check if the minimum amount is at least £1' do
      expect { subject.touch_in }.to raise_error "balance is not enough"
    end

    it 'after touch in it remembers an entry_station'
    let(:station){ double :station }
      subject.top_up(10)
      subject.touch_in(:station)
      expect(subject.current_station).to eq(:station)
  end

  describe '#touch_out' do

    it 'expects touch_out to change journey_status to false' do
      subject.top_up(1)
      subject.touch_in
      subject.touch_out
      expect(subject.in_journey?).to eq(false)
    end

    it 'expects touch out to reduce balance by minimum amount' do
      subject.top_up(5)
      subject.touch_in
      expect { subject.touch_out }.to change { subject.balance }.by(-Oystercard::MINIMUM_FARE)
    end
  end


end
