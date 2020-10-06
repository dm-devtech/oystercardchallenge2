class Oystercard
  BALANCE_LIMIT = 90

  attr_reader :balance

  def initialize
    @balance = 0
    @journey_status = false
  end

  def top_up(amount)
    raise 'You cannot have more than £90 in your balance' if @balance + amount > BALANCE_LIMIT

    @balance += amount
  end

  def deduct(deducted_am)
    @balance -= deducted_am
  end

  def in_journey?
    @journey_status
  end

  def touch_in
    @journey_status = true
  end

  def touch_out
    @journey_status = false
  end
end
