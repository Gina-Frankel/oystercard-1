require 'oystercard'

describe Oystercard do

  let(:edgeware) { double(:station) }
  let(:waterloo) { double(:waterloo) }


  it 'oystercard has a balance of 0' do
    expect(subject).to have_attributes(:balance => 0)
  end

  context '#top_up' do
    it 'oystercard responds to method top_up' do
      expect(subject).to respond_to(:top_up).with(1).argument
    end
  
    it 'can top up the balance' do
      expect{ subject.top_up 1 }.to change{ subject.balance }.by 1
    end

    it '#top_up fails if over balance' do
      expect{ subject.top_up(Oystercard::CARD_LIMIT + 1) }.to raise_error "Over limit"
    end
  end

  context '#touch_in' do 
    it 'responds with 1 argument' do
      expect(subject).to respond_to(:touch_in).with(1).argument
    end

    it 'starts journey' do
      subject.top_up(1)
      subject.touch_in(edgeware)
      expect(subject.in_journey?).to eq true
    end

    it 'will not allow card to touch in and will throw an error if have less than one pound in balance' do
      expect { subject.touch_in(edgeware) }.to raise_error "insufficient balance"
    end 
    it 'will save the station to the entry_station on touch_in' do
      subject.top_up(1)
      subject.touch_in(edgeware)
      expect(subject.entry_station).to eq edgeware
    end 

    # testing state rather than behaviour, oops!
    it 'touching in and out creates one journey' do
      subject.top_up(1)
      subject.touch_in(edgeware)
      subject.touch_out(waterloo)
      expect(subject.journey_list).to eq [{:entry => edgeware, :exit => waterloo}]
    end
  end

  context '#touch_out' do 
    it 'ends journey' do
      expect(subject).to respond_to(:touch_out)
      expect(subject.in_journey?).to eq false
    end 

    it 'deduct money from balance' do
      subject.top_up(10)
      subject.touch_in(edgeware)
      expect { subject.touch_out(waterloo) }.to change { subject.balance }.by (-1)
    end 

    it 'changes entry_station back to nil on touch_out' do
      subject.top_up(10)
      subject.touch_in(edgeware)
      subject.touch_out(waterloo)
      expect(subject.entry_station).to eq nil
    end 
  end 
end
