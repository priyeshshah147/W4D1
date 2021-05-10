require "byebug"
class PolyTreeNode

    attr_reader :value, :parent, :children
    
    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(node)
        if @parent != nil
            @parent.children.delete(self)
        end
        @parent = node
        node.children << self if node && !node.children.include?(self)
    end
    
    def add_child(child_node)
        if !children.include?(child_node)
            children << child_node
            child_node.parent = self
        end
    end

    def remove_child(child_node)
        if children.include?(child_node)
            child_node.parent = nil
        else 
            raise "no valid child"
        end
    end

    def dfs(target_value)

        # debugger
        return self if value == target_value
        children.each do |child|
            result = child.dfs(target_value)
            return result if result
        end
        return nil
       
    end

    def bfs(target_value)
        if value == target_value
            return self
        end
        child_arr = children
        while child_arr.length > 0
            # debugger
            if child_arr[0].value == target_value
                return child_arr[0]
            else
                child_arr += child_arr[0].children
                child_arr.shift
            end
        end
        return nil if child_arr.empty?
        
    end

end
