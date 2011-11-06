module Gol
  module Gui
    class Field
      attr_reader :shape

      def initialize(shape)
        @shape = shape
      end

      def toggle
        @spape.fill('black')
      end
    end
  end
end
