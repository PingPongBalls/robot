require 'spec_helper'

describe 'Simulator' do 

  before(:each) { 
    @simulator = Simulator.instance 
  }

  describe 'run' do

    context 'with invalid commands' do
      it 'should return error message' do
        expect(@simulator.run('InvalidCommand')).to match 'Command not found'
      end

      it 'should return error message when passing invalid number as params' do
        expect(@simulator.run('PLACE A,2,SOUTH')).to match 'PLACE with invalid arguments. Please check and try again.'
      end
    end
    
    context 'without robot on table' do 

      before do 
        allow(@simulator.table).to receive(:been_placed?).and_return(false)
      end

      it 'should not raise error when calling REPORT' do
        expect{@simulator.run('REPORT')}.not_to raise_error
      end

      it 'should not raise error when calling LEFT' do
      	expect{@simulator.run('LEFT')}.not_to raise_error
      end

      it 'should not raise error when calling MOVE' do
        expect{@simulator.run('MOVE')}.not_to raise_error
      end

      it 'should has position of [1,3] when calling PLACE 1,3,WEST' do
        @simulator.run('PLACE 1,3,WEST')
        expect(@simulator.table.position).to match_array [[:x,1], [:y,3]]
      end
    end

    context 'with a robot on the table' do
      before do 
        allow(@simulator.table).to receive(:been_placed?).and_return(true)
        allow(@simulator.table).to receive(:position).and_return({:x=>2, :y=>3})
        allow(@simulator.robot).to receive(:orientation).and_return(:north)
      end

      it 'should return string of current status when calling REPORT' do
        expect(@simulator.run('REPORT')).to match('2,3,NORTH')
      end
      
      it 'should trun left when calling LEFT' do
        allow(@simulator.robot).to receive(:orientation).and_return(:west)
        @simulator.run('LEFT')
        expect(@simulator.run('LEFT')).to match('2,3,WEST')
      end
      
      it 'should turn nothing when calling MOVE' do        
        expect(@simulator.run('MOVE')).to be nil
      end

      
    end

  end
end