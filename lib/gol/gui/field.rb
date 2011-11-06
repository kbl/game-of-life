module Gol
  module Gui
    class Field
      attr_reader :shape

      def initialize(shape)
        @shape = shape
      end

      def toggle
        @shape.fill('black')
      end
    end
  end
end
