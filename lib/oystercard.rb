class Oystercard
  BALANCE_LIMIT = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 1

  attr_reader :balance

  def initialize
    @balance = 0
    @journey_status = false
  end

  def top_up(amount)
    raise "Maximum balance is £#{BALANCE_LIMIT}." if @balance + amount > BALANCE_LIMIT

    @balance += amount
  end
private
  def deduct(deducted_am = MINIMUM_FARE)
    @balance -= deducted_am
  end
public
  def in_journey?
    @journey_status
  end

  def touch_in
    raise "balance is not enough" if @balance < MINIMUM_BALANCE
    @journey_status = true
  end

  def touch_out
    @journey_status = false
    deduct()
  end
end
