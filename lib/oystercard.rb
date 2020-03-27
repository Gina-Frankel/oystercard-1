# frozen_string_literal: true

class Oystercard
  attr_reader :balance, :entry_station, :journey_list
  CARD_LIMIT = 90
  MINIMUM_FUNDS = 1
  MINIMUM_FARE = 1
  STARTING_BALANCE = 0

  def initialize
    @balance = STARTING_BALANCE
    @entry_station = nil
    @journey_list = []
  end

  def top_up(amount)
    raise 'Over limit' if @balance + amount > CARD_LIMIT
    @balance = amount
  end

  def touch_in(station)
    raise "insufficient balance" if @balance < MINIMUM_FUNDS
    @entry_station = station
    save_start_journey(station)
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @entry_station = nil
    @current_journey[:exit] = station
  end

  def in_journey?
    entry_station == nil ? false : true
  end

 private

  def deduct(amount)
    @balance -= amount
  end

  def save_start_journey(station)
    @current_journey = Hash.new
    @current_journey[:entry] = station
    @journey_list.push(@current_journey)
  end
  
end
