module BinarySearchTree
  class Node
    include Comparable

    attr_accessor :value, :left_child, :right_child

    def <=>(other)
      @value <=> other.value
    end

    def initialize(value = nil)
      @value = value
      @left_child = nil
      @right_child = nil
    end

    def to_s
      "{ node: #{value}, " +
      "left_child: #{left_child.nil? ? 'nil' : left_child.value}, " +
      "right_child: #{right_child.nil? ? 'nil' : right_child.value} }"
    end
  end
end
