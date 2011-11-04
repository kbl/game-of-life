require 'spec_helper'

module Gol
  describe Board do

    subject { Board.new }

    def cell(*cords)
      Cell.new(subject, *cords)
    end

    describe 'board creation' do
      it 'shouldnt have any cells' do 
        subject.should be_empty
      end
      it 'should remember created cells' do
        cell(0, 0)
        cell(1, 3)

        subject.count.should == 2
      end
    end

    describe 'cell access' do
      it 'should have access to cell at specified cords' do 
        cell = Cell.new(subject)
        subject[0, 0].should == cell
      end
      it 'should return nil for unknown cell' do
        subject[123, 12].should be_nil
      end
    end

    describe 'checkig cell at any position' do 
      it 'empty array for clear board' do
        subject.neighbours(1, 1).should be_empty
      end
      it 'should return 2 neighbours' do
        c00 = cell(0, 0)
        c10 = cell(1, 0)

        subject.neighbours(1, 1).should contain([c10, c00])
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
            c3.neighbours.count.should == 3
            c3.neighbours[0].x.should == 2
            c3.neighbours[0].y.should == 2
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
