class Node
    attr_accessor :data
    attr_accessor :left
    attr_accessor :right
    def initialize(root)
        @data = root
        @left = nil
        @right = nil
    end
end

class Tree
    attr_accessor :root

    def initialize(array)
        @array = array.sort.uniq
        @root = nil
    end

    def build_tree(left=0,right=@array.size-1)
        return nil if left > right
        midpoint = (left + right)/2

        node = Node.new(@array[midpoint])
        @root = node unless @root != nil

        node.left = build_tree(left,midpoint-1)
        node.right = build_tree(midpoint+1,right)

        return node

    end

    def debug
    end

    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end
end

tree = Tree.new([1,7,4,23,8,9,4,3,5,7,9,67,6345,324])

tree.build_tree
tree.pretty_print