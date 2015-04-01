require 'spec_helper'

describe 'Tabletop' do 

  before(:each) { @table = Table.new }
  subject { @table}

  it { should respond_to :place }
  it { should respond_to :been_placed? }

  context 'position' do 

    it 'should reject if new position contains negative number' do
      @table.place(-1,-1)
      expect(@table.position).to be nil
    end

  end

  context 'calls been_placed' do
    it "should return false without a placed position" do
      expect(@table.been_placed?).to be false
    end

    it 'should return true after updating with a valid position' do
      @table.place("2","2")
      expect(@table.been_placed?).to be true
    end
  end
end