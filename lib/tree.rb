require_relative 'node.rb'

module BinarySearchTree
  class Tree
    def initialize(arr)
      cleaned_arr = arr.uniq.sort
      @root = build_tree(cleaned_arr, 0, cleaned_arr.size - 1)
    end

    def build_tree(arr, first_index, last_index)
      return nil if first_index > last_index

      mid_index = (first_index + last_index) / 2
      root = Node.new(arr[mid_index])
      root.left_child = build_tree(arr, first_index, mid_index - 1)
      root.right_child = build_tree(arr, mid_index + 1, last_index)
      root
    end

    def insert(value)
      @root = Tree.insert_to_root(@root, value)
    end

    def delete(value)
      @root = Tree.delete_from_root(@root, value)
    end

    def find(value, root = @root)
      return root if root.nil? || value == root.value

      if value < root.value
        find(value, root.left_child)
      else
        find(value, root.right_child)
      end
    end

    def level_order
      values = []
      queue = [@root]

      until queue.empty?
        node = queue.shift
        queue << node.left_child unless node.left_child.nil?
        queue << node.right_child unless node.right_child.nil?
        values << node.value
      end
      values
    end

    def level_order_recurse(queue = [@root])
      return [] if queue.empty?

      node = queue.shift
      queue << node.left_child unless node.left_child.nil?
      queue << node.right_child unless node.right_child.nil?
      [node.value].concat(level_order_recurse(queue))
    end

    def inorder(root = @root)
      return [] if root.nil?

      values = []
      values.concat(inorder(root.left_child))
      values << root.value
      values.concat(inorder(root.right_child))
      values
    end

    def preorder(root = @root)
      return [] if root.nil?

      values = []
      values << root.value
      values.concat(preorder(root.left_child))
      values.concat(preorder(root.right_child))
      values
    end

    def postorder(root = @root)
      return [] if root.nil?

      values = []
      values.concat(postorder(root.left_child))
      values.concat(postorder(root.right_child))
      values << root.value
      values
    end

    def height(root = @root)
      return -1 if root.nil?

      left_height = height(root.left_child)
      right_height = height(root.right_child)
      left_height > right_height ? left_height + 1 : right_height + 1
    end

    def depth(node, root = @root)
      return nil if root.nil?
      return 0 if node == root

      if node < root
        depth(node, root.left_child) + 1
      else
        depth(node, root.right_child) + 1
      end
    end

    def balanced?
      return true if @root.nil?
      (height(@root.left_child) - height(@root.right_child)).abs <= 1
    end

    def rebalance
      values = level_order.uniq.sort
      @root = build_tree(values, 0, values.size - 1)
    end

    # Shared method from TOP's Discord
    def pretty_print(node = @root, prefix = '', is_left = true)
      pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
      puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
      pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
    end

    private

    def self.insert_to_root(root, value)
      return Node.new(value) if root.nil?
      return root if value == root.value

      if value < root.value
        root.left_child = insert_to_root(root.left_child, value)
      else
        root.right_child = insert_to_root(root.right_child, value)
      end
      root
    end

    def self.delete_from_root(root, value)
      return nil if root.nil?

      if value < root.value
        root.left_child = delete_from_root(root.left_child, value)
      elsif value > root.value
        root.right_child = delete_from_root(root.right_child, value)
      else
        if root.left_child.nil?
          return root.right_child
        elsif root.right_child.nil?
          return root.left_child
        end

        min_parent = root
        min_child = root.right_child
        until min_child.left_child.nil?
          min_parent = min_child
          min_child = min_child.left_child
        end

        if min_parent == root # first min_child is the min
          min_parent.right_child = min_child.right_child
        else
          min_parent.left_child = min_child.right_child
        end

        root.value = min_child.value
      end
      root
    end
  end
end
