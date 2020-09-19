require_relative 'lib/tree.rb'

def print_tree_is_balanced(tree)
  puts "Tree is balanced?: #{tree.balanced?}"
  puts ''
end

def print_all_order(tree)
  puts 'Node values in level-order:'
  p tree.level_order
  puts ''

  puts 'Node values in preorder:'
  p tree.preorder
  puts ''

  puts 'Node values in postorder:'
  p tree.postorder
  puts ''

  puts 'Node values in inorder:'
  p tree.inorder
  puts ''
end

arr = Array.new(15) { rand(1..100) }
puts 'Creating binary search tree from array...'
p arr
puts ''

tree = BinarySearchTree::Tree.new(arr)
tree.pretty_print
puts ''

print_tree_is_balanced(tree)
print_all_order(tree)

puts 'Inserting numbers greater than 100 to unbalance the tree..'
5.times { tree.insert(rand(101..200)) }
tree.pretty_print
puts ''

print_tree_is_balanced(tree)

puts 'Rebalancing the tree...'
tree.rebalance
tree.pretty_print
puts ''

print_tree_is_balanced(tree)
print_all_order(tree)
