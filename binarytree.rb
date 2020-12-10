class Node
    attr_accessor :data, :left, :right
    def initialize(root)
        @data = root
        @left = nil
        @right = nil
    end
end

class Tree
    attr_accessor :root

    def initialize(array=[])
        @array = array.sort.uniq
        @root = nil
    end

    def build_tree(left=0,right=@array.size-1)
        return nil if left > right
        midpoint = (left + right)/2

        node = Node.new(@array[midpoint])
        @root = node if @root == nil

        node.left = build_tree(left,midpoint-1)
        node.right = build_tree(midpoint+1,right)

        return node
    end

    def insert(value,node=nil)
        return @root = Node.new(value) if @root == nil   #If inserting to an empty tree
        node = @root if node == nil

        if value == node.data
            puts "#{value} is already in the tree."
            return
        elsif value < node.data
            if node.left == nil
                node.left = Node.new(value)
                return
            end
            insert(value,node.left)
        else
            if node.right == nil
                node.right = Node.new(value)
                return
            end
            insert(value,node.right)
        end
    end

    def delete(value,node)
        return if node == nil #Empty Tree

        if value < node.data
            node.left = delete(value, node.left)
        elsif value > node.data
            node.right = delete(value, node.right)
        else
            if node.left == nil
                return node.right
            elsif node.right == nil
                return node.left
            end

            node.data = minValue(node.right)

            node.right = delete(node.data, node.right)
        end
        return node
    end

    def minValue(node)  # Retrieves inorder successor for node with two children
        min = node.data
        while node.left != nil
            min = node.left.data
            node = node.left
        end
        return min
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

tree.delete(10, tree.root)
puts "After Deletion:"
tree.pretty_print