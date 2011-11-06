require 'spec_helper'

module Gol
  describe Cell do
    describe 'neighbourhood' do
      it 'should return array of neighbourhood cords' do
        c = Cell.new(1, 1)
        n = c.neighbours
        n.size.should == 8
        n.should == [[0, 1], [0, 2], [1, 2], [2, 2], [2, 1], [2, 0], [1, 0], [0, 0]]
      end
    end

    describe 'cell creation' do
      subject { Cell.new(1, 2) }

      it 'should create new cell at given location x' do
        subject.x.should == 1
      end
      it 'should create new cell at given location y' do
        subject.y.should == 2
      end
      it 'cell created without any cords should have position 0,0' do
        cell = Cell.new
        cell.x.should == 0
        cell.y.should == 0
      end
    end

    describe 'cell live state' do
      subject { Cell.new }

      it 'newly created cell should be dead' do
        subject.should_not be_alive
      end
      it 'cell marked as die shouldnt be alive' do
        subject.pulverize
        subject.should_not be_alive
      end
      it 'cell marked as live shouldnt be alive' do
        subject.pulverize
        subject.should_not be_alive
        subject.resurrect
        subject.should be_alive
      end
      it 'toggle should chagne cell state' do
        subject.should_not be_alive
        subject.toggle
        subject.should be_alive
      end
    end

    describe 'Cell#cords' do
      it 'should properly show cell cords' do
        Cell.new(3, 5).cords.should == [3, 5]
      end
    end
  end
end
