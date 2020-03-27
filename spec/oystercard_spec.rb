require './lib/oystercard'

describe Oystercard do
  subject(:card) {Oystercard.new}
  
  it 'oystercard has a balance of 0' do
    expect(card).to have_attributes(:balance => 0)
  end
  
  context '#top_up' do
    it 'oystercard responds to method top_up' do
      expect(card).to respond_to(:top_up).with(1).argument
    end
    
    it 'can top up the balance' do
      expect{ card.top_up 1 }.to change{ card.balance }.by 1
    end
    
    it '#top_up fails if over balance' do
      expect{ card.top_up(95) }.to raise_error "Over limit"
    end
    
    it 'returns an empty list of journeys by default' do
      expect(card.journeys).to eq []
    end
    
  end  
  
  
  context '#touch_in' do 
    it 'start journey' do
      expect(card).to respond_to(:touch_in).with(1).argument
      card.top_up(1)
      card.touch_in("edgeware")
      expect(card.in_journey?).to eq true
    end
    
    it 'will not allow card to touch in  and will throw an error  if have less than one pound in balance' do
      expect { card.touch_in('edgeware')}.to raise_error "insufficient balance"
    end 
    it 'will save the  station to the entry_station on touch_in' do
      card.top_up(1)
      card.touch_in("edgeware")
      expect(card.entry_station).to eq "edgeware"
    end 
    
    it 'touching in and out creates one journey' do
      card.top_up(1)
      card.touch_in("edgeware")
      card.touch_out("waterloo")
      expect(card.journeys).to eq [{:entry => "edgeware", :exit => "waterloo"}]
    end

    let(:journey) {Journey.new("Edgeware")}
    
    it "touching in starts a new journey" do 
      card.top_up(1)
      expect(card.touch_in("Edgeware")).to eq journey
      #subject(:journey) {Journey.new("Edgeware")}
    end 
    
  end
  

  context '#touch_out' do 
    it 'ends journey' do
    expect(card).to respond_to(:touch_out)
    expect(card.in_journey?).to eq false
    end 

    it 'deduct money from balance' do
      card.top_up(10)
      card.touch_in("edgeware")
      expect{card.touch_out("waterloo")}.to change{ card.balance }.by (-1)
    end 

    it 'changes entry_station back to nil on touch_out' do
      card.top_up(10)
      card.touch_in('edgeware')
      card.touch_out("waterloo")
      expect(card.entry_station).to eq nil
    end 
  end 



    #expect { subject.deduct(1) }.to change{ subject.balance }.by (-1)
      # what about if it goes under 0
  
end

#Write a test that checks that an error is thrown if 
#a card with insufficient balance is touched in