require 'rspec'
require 'cell'

describe Cell do

  describe 'state' do
    subject { Cell.new }

    it 'newly created cell should be alive' do
      subject.should be_alive
    end
  end

  describe 'neighbourhood' do
    it 'sholuld create cell without any neighbours' do
      cell = Cell.new
      cell.neighbours.should be_empty
    end

    context 'creating two cells' do
      let(:cell00) { Cell.new(0, 0) }
      let(:cell01) { Cell.new(0, 1) }

      it 'should have one neighbour' do
        pending 
        cell00.neighbours.count.should == 1
        cell01.neighbours.count.should == 1
      end

      it 'should contain neighbours' do
        pending 
        cell00.neighbours[0].should == cell01
        cell01.neighbours[0].should == cell02
      end
    end
  end

  describe 'cell spawning' do
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

end
