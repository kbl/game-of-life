require 'spec_helper'

module Gol
  module Gui
    describe Board do
      subject { Board.new }

      it 'should be possible to create board with default size 50x50' do
        subject.x.should == 50
        subject.y.should == 50
      end
      it 'should be possible to create board with chosen size' do
        board = Board.new(20, 30)

        board.x.should == 20
        board.y.should == 30
      end
      it 'assigned shape should be packed in field instance' do
        subject[1, 2] = 'test_shape'
        subject[1, 2].should == 'test_shape'
      end
    end
  end
end
