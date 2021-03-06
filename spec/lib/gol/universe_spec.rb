require 'spec_helper'

module Gol
  describe Universe do

    subject { Universe.new }

    def cell(x, y)
      subject.toggle(x, y)
      [x, y]
    end

    describe 'universe creation' do
      it 'shouldnt have any cells' do 
        subject.should be_empty
      end
      it 'should remember created cells' do
        cell(0, 0)
        cell(1, 3)

        subject.count.should == 2
      end
    end

    describe 'Universei#dead_neighbours' do
      it 'should have 8 dead neighbours' do
        subject.toggle(1, 1)
        subject.dead_neighbours(1, 1).size.should == 8
      end
      it 'should have 8 dead neighbours (corner)' do
        subject.toggle(0, 0)
        subject.dead_neighbours(0, 0).size.should == 8
      end
      it 'should have 8 dead neighbours (edge)' do
        subject.toggle(1, 0)
        subject.dead_neighbours(1, 0).size.should == 8
      end
    end

    describe 'Universe#neighbours' do
      before :each do
        @center = [1, 1]
        subject.toggle(*@center)
      end

      it 'should have one neighbour (0,0)' do
        c = cell(0, 0)
        subject.neighbours(*@center).should have_neighbours(c)
      end
      it 'should have one neighbour (0,1)' do
        c = cell(0, 1)
        subject.neighbours(*@center).should have_neighbours(c)
      end
      it 'should have one neighbour (0,2)' do
        c = cell(0, 2)
        subject.neighbours(*@center).should have_neighbours(c)
      end
      it 'should have one neighbour (1,0)' do
        c = cell(1, 0)
        subject.neighbours(*@center).should have_neighbours(c)
      end
      it 'should have one neighbour (1,2)' do
        c = cell(1, 2)
        subject.neighbours(*@center).should have_neighbours(c)
      end
      it 'should have one neighbour (2,0)' do
        c = cell(2, 0)
        subject.neighbours(*@center).should have_neighbours(c)
      end
      it 'should have one neighbour (2,1)' do
        c = cell(2, 1)
        subject.neighbours(*@center).should have_neighbours(c)
      end
      it 'should have one neighbour (2,2)' do
        c = cell(2, 2)
        subject.neighbours(*@center).should have_neighbours(c)
      end
    end

    describe 'Universe#[]' do
      it 'should have access to cell at specified cords' do 
        subject[0, 0].should_not be_nil
      end
      it 'cords should be counded with %' do
        subject.toggle(123, 12)
        subject[123, 12].should be_true
      end
    end

    describe 'checkig cell at any position' do 
      it 'empty array for clear universe' do
        subject.neighbours(1, 1).should be_empty
      end
      it 'should return 2 neighbours' do
        c00 = cell(0, 0)
        c10 = cell(1, 0)

        subject.neighbours(1, 1).should contain([c10, c00])
      end
    end

    describe 'universe size' do
      it 'should be possible to get size of each axis' do
        u = Universe.new(4, 5)
        u.x.should == 4
        u.y.should == 5
      end
    end

    describe 'infinite universe' do
      it 'should create cells on infinite manner (101,102) becomes (1,2)' do
        cell(101, 102)

        subject.count.should == 1
        subject[1, 2].should be_true
      end
      it 'should be possible to put cell on borders - edge case' do
        cell(99, 99)

        subject[99, 99].should be_true
      end
      it 'should find neighbours on universe edges' do
        c0_0 = cell(0, 0)
        c0_1 = cell(0, 1)
        c0_99 = cell(0, 99)

        c1_0 = cell(1, 0)
        c1_1 = cell(1, 1)
        c1_99 = cell(1, 99)

        c99_0 = cell(99, 0)
        c99_1 = cell(99, 1)
        c99_99 = cell(99, 99)

        subject.neighbours(0, 0).should contain([c99_0, c99_1, c0_1, c1_1, c1_0, c1_99, c0_99, c99_99])
      end
    end

    describe 'Universe#toggle' do
      it 'should be possible to clreate new cell by toggling empty universe position' do
        subject.count.should == 0

        subject.toggle(0, 0)

        subject.count.should == 1
        subject[0, 0].should be_true
      end
      it 'toggling should remove existing cell' do
        cell(0, 0)
        subject.count.should == 1

        subject.toggle(0, 0)

        subject.count.should == 0
      end
    end

    describe 'Universe#tick' do
      context 'repeated ticks' do
        it 'blinker oscilator' do
          cell(1, 0)
          cell(1, 1)
          cell(1, 2)

          10.times do |i|
            subject.tick
            subject.count.should == 3
          end
        end
      end
      context 'view callbacks' do
        let(:callback) { mock('callback') }

        it 'shouldnt get any event' do
          subject.tick
        end
        it 'should pass remove event to callback' do
          cell(1, 1)
          callback.should_receive(:repaint).with(1, 1)
          subject.tick(callback)
        end
        it 'should pass 2 remove events' do
          cell(1, 1)
          cell(2, 1)
          
          callback.should_receive(:repaint).with(1, 1)
          callback.should_receive(:repaint).with(2, 1)

          subject.tick(callback)
        end
        it 'should pass 2 remove and 2 create events to view' do
          cell(1, 1)
          cell(2, 1)
          cell(3, 1)

          callback.should_receive(:repaint).with(1, 1)
          callback.should_receive(:repaint).with(3, 1)
          callback.should_receive(:repaint).with(2, 0)
          callback.should_receive(:repaint).with(2, 2)

          subject.tick(callback)
        end
      end
    end

    describe 'rules' do
      context 'rule 1: Any live cell with fewer than two live neighbours dies, as if caused by under-population' do
        it 'should destroy cells with neighbourhood = 0' do
          cell(1, 1)
          subject.count.should == 1

          subject.tick

          subject.should be_empty
        end
        it 'should destroy cells with neighbourhood = 1' do
          cell(1, 1)
          cell(1, 2)
          subject.count.should == 2

          subject.tick

          subject.should be_empty
        end
      end
      context 'rule 2: Any live cell with two or three live neighbours lives on to the next generation' do
        it 'should leave cells with neighbourhood = 2' do
          c1 = cell(1, 1)
          c2 = cell(1, 2)
          c3 = cell(2, 1)
          subject.count.should == 3

          subject.tick

          subject.should contain([c1, c2, c3])
        end
        it 'should leave cells with neighbourhood = 3' do
          c1 = cell(1, 1)
          c2 = cell(1, 2)
          c3 = cell(2, 1)
          c4 = cell(0, 0)
          subject.count.should == 4

          subject.tick

          subject.should contain([c1, c2, c3])
        end
      end
      context 'rule 3: Any live cell with more than three live neighbours dies, as if by overcrowding' do
        it 'should destroy cells with neighbourhood = 4' do
          c1 = cell(0, 1)
          c2 = cell(1, 1)
          c3 = cell(2, 1)
          c4 = cell(1, 0)
          c5 = cell(1, 2)
          subject.count.should == 5

          subject.tick

          subject.should contain([c1, c3, c4, c5])
        end
        context 'rule 4: Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction' do
          it 'should reproduct dying cell with three neighbours' do
            c1 = cell(1, 1)
            c2 = cell(2, 1)
            c3 = cell(1, 2)
            subject.count.should == 3

            subject.tick

            subject.should contain([c1, c2, c3])
            subject.count.should == 4

            neighbours = subject.neighbours(*c3)
            neighbours.size.should == 3
            neighbours[0].should == [2, 2]
          end
          it 'should properly reproduct cells (6 from 4)' do
            c1 = cell(1, 1)
            c2 = cell(1, 2)
            c3 = cell(2, 1)
            c4 = cell(0, 0)
            subject.count.should == 4

            subject.tick

            subject.count.should == 6
          end
          it 'should properly reproduct cells (8 from 5)' do
            c1 = cell(0, 1)
            c2 = cell(1, 1)
            c3 = cell(2, 1)
            c4 = cell(1, 0)
            c5 = cell(1, 2)
            subject.count.should == 5

            subject.tick

            subject.count.should == 8
          end
        end
      end
    end

  end
end
