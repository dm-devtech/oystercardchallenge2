class Oystercard
    attr_reader :balance

    def initialize
        @balance = 0
    end

    def top_up(amount)
        fail 'You cannot have more than £90 in your balance' if @balance + amount > 90
        @balance += amount
    end
    
    def deduct(deducted_am)
        @balance -= deducted_am
    end

end