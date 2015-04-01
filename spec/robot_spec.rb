require 'spec_helper'

describe 'Robot' do

  before(:each) { @robot = Robot.new }
  subject {@robot}

  it { should respond_to :face_to }
  it { should respond_to :turn }
  it { should respond_to :move_forward }

  context 'set orientation' do 
    it 'should return nil if new orientation is not valid' do
      expect(@robot.face_to(:south_east)).to be == nil
    end

    it 'should return :west if new orientation set to west' do
      expect(@robot.face_to(:west)).to eql(:west)
    end
  end

  context 'can turn' do
    before(:each) { @robot.face_to(:east) }

    it 'left to face :north' do
      expect(@robot.turn(:left)).to be :north
    end
    
    it 'right to face :east' do 
      expect(@robot.turn(:right)).to equal(:south)
    end
  end

  context 'move forward' do
    it 'should return nil without setting direction' do
      expect(@robot.move_forward).to be_nil
    end

    it 'should return an array contains distance' do
      @robot.face_to(:north)
      expect(@robot.move_forward).to match_array([{ x: 0, y: 1 }])
    end
  end
end