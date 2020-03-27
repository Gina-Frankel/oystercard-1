require 'journey'

describe Journey do

  let(:edgware) { double :edgware }
  let(:waterloo) { double :waterloo }

  it 'initialises with entry and exit as nil' do
    expect(subject).to have_attributes(entry: nil, exit: nil)
  end

  it '#start adds starting station to entry' do
    subject.start(edgware)
    expect(subject.entry).to eq edgware
  end

  it '#finish adds a end station to exit' do
    subject.start(edgware)
    subject.finish(waterloo)
    expect(subject.exit).to eq waterloo
  end

  context '#fare' do
    it 'returns 1 if there is an entry and exit station' do
      subject.start(edgware)
      subject.finish(waterloo)
      expect(subject.fare).to eq 1
    end
  
    it 'returns 6 if there is an entry but no exit station' do
      subject.start(edgware)
      expect(subject.fare).to eq 6
    end
    it 'returns 6 if there is an exit but no entry station' do
      subject.finish(waterloo)
      expect(subject.fare).to eq 6
    end
  end

end