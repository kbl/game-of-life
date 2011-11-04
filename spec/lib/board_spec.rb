require 'spec_helper'

describe Board do

  subject { Board.new }

  describe 'board creation' do
    it 'shouldnt have any cells' do 
      subject.should be_empty
    end
    it 'should remember created cells' do
      Cell.new(subject)
      Cell.new(subject, 1, 3)

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

  describe 'rules' do
    context 'rule 1: Any live cell with fewer than two live neighbours dies, as if caused by under-population' do
      it 'should destroy cells with neighbourhood = 0' do
        Cell.new(subject, 1, 1)
        subject.count.should == 1

        subject.tick

        subject.should be_empty
      end
      it 'should destroy cells with neighbourhood = 1' do
        Cell.new(subject, 1, 1)
        Cell.new(subject, 1, 2)
        subject.count.should == 2

        subject.tick

        subject.should be_empty
      end
    end
    context 'rule 2: Any live cell with two or three live neighbours lives on to the next generation' do
      it 'should leave cells with neighbourhood = 2' do
        c1 = Cell.new(subject, 1, 1)
        c2 = Cell.new(subject, 1, 2)
        c3 = Cell.new(subject, 2, 1)
        subject.count.should == 3

        subject.tick

        subject.should include([c1, c2, c3])
      end
      it 'should leave cells with neighbourhood = 3' do
        c1 = Cell.new(subject, 1, 1)
        c2 = Cell.new(subject, 1, 2)
        c3 = Cell.new(subject, 2, 1)
        c4 = Cell.new(subject, 0, 0)
        subject.count.should == 4

        subject.tick

        subject.should include([c1, c2, c3])
        subject.count.should == 3
      end

    end
  end

end
