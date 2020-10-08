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
  let(:station) { double :station }

    it { is_expected.to respond_to(:touch_in).with(1).argument }

    it 'checks that touch in changes journey status to true' do
      subject.top_up(1)
      subject.touch_in(station)
      expect(subject.in_journey?).to eq(true)
    end

    it 'check if the minimum amount is at least £1' do
      expect { subject.touch_in(station) }.to raise_error "balance is not enough"
    end

    it 'stores entry station' do
      subject.top_up(1)
      subject.touch_in(station)
      expect(subject.entry_station).to eq(station)
    end

    it 'after touch in it remembers an entry_station' do
      subject.top_up(10)
      subject.touch_in(station)
      expect(subject.entry_station).to eq(station)
     end
  end

  describe '#touch_out' do
    let(:station) { double :station }
      it 'expects touch_out to change journey_status to false' do
        subject.top_up(1)
        subject.touch_in(station)
        subject.touch_out(station)
        expect(subject.in_journey?).to eq(false)
      end

      it 'expects touch out to reduce balance by minimum amount' do
        subject.top_up(5)
        subject.touch_in(station)
        expect { subject.touch_out(station) }.to change { subject.balance }.by(-Oystercard::MINIMUM_FARE)
      end
  end

  describe '#touch_out exit station' do
    let(:entry_station) { double :station }
    let(:exit_station) { double :station }
    let(:journey){ {entry_station: entry_station, exit_station: exit_station} }

    it 'expects the station history to be empty before first journey' do
      expect(subject.journeys).to be_empty
    end

    it 'stores exit station' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.exit_station).to eq(exit_station)
    end

    it 'stores a journey' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journeys).to include journey
    end
  end
end
