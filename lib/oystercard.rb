class Oystercard
  BALANCE_LIMIT = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 1

  attr_reader :balance, :entry_station, :station_history

  def initialize
    @balance = 0
    @journey_status = false
    @entry_station
    @station_history = []
  end

  def top_up(amount)
    raise "Maximum balance is £#{BALANCE_LIMIT}." if @balance + amount > BALANCE_LIMIT
    @balance += amount
  end

  def in_journey?
     !!@entry_station
  end

  def touch_in(station)
    raise "balance is not enough" if @balance < MINIMUM_FARE
    @entry_station = station
    @station_history
  end

  def touch_out(end_station)
    deduct()
    @end_station = end_station
    @station_history << {:start=>@entry_station, :end=>@end_station}
    @entry_station = nil
  end

  private
    def deduct(deducted_am = MINIMUM_FARE)
      @balance -= deducted_am
    end
end
