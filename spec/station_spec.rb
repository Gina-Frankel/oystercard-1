require './lib/station.rb'

describe Station do
    subject(:station) { Station.new('waterloo', 1) }
    it 'knows its name' do
        expect(station.name).to eq('waterloo')
    end
    it 'knows its zone' do
        expect(station.zone).to eq(1)
    end
end