# require_relative "\skeleton\lib\00_tree_node.rb"
require_relative "../skeleton/lib/00_tree_node.rb"

class KnightPathFinder


    attr_accessor :root_node
    def initialize(pos)
        @start = pos
        @considered_positions = [pos]
        build_move_tree
    end

    def self.valid_moves(pos)
        moves = []
        
        moves << [pos[0] + 2, pos[1] + 1] if pos[0] + 2 < 8 && pos[1] + 1 < 8
        moves << [pos[0] + 1, pos[1] + 2] if pos[0] + 1 < 8 && pos[1] + 2 < 8
        
        moves << [pos[0] + 1, pos[1] - 2] if pos[0] + 1 < 8 && pos[1] - 2 >= 0
        moves << [pos[0] + 2, pos[1] - 1] if pos[0] + 2 < 8 && pos[1] - 1 >= 0
        
        moves << [pos[0] - 1, pos[1] + 2] if pos[0] - 1 >= 0 && pos[1] + 2 < 8
        moves << [pos[0] - 2, pos[1] + 1] if pos[0] - 2 >= 0 && pos[1] + 1 < 8
        
        moves << [pos[0] - 1, pos[1] - 2] if pos[0] - 1 >= 0 && pos[1] - 2 >= 0
        moves << [pos[0] - 2, pos[1] - 1] if pos[0] - 2 >= 0 && pos[1] - 1 >= 0

        moves
    end

    def new_move_positions(pos)
        moves = KnightPathFinder.valid_moves(pos)
        new_pos = []
        moves.each do |move|
            if !@considered_positions.include?(move)
                @considered_positions << move
                new_pos << move
            end
        end
        new_pos
    end

    def build_move_tree
        self.root_node = PolyTreeNode.new(@start)
        queue = [self.root_node]
        until queue.empty?
            current_node = queue.shift
            new_move_positions(current_node.value).each do |pos|
                new_node = PolyTreeNode.new(pos)
                current_node.add_child(new_node)
                queue << new_node
            end
        end         
    end

    def find_path(end_pos)
        
        trace_path_back(root_node.bfs(end_pos)) + [end_pos]
    end

    def trace_path_back(root_node)
        pos = []
        queue = [root_node.parent]
        until queue[0] == nil
            new_pos = queue.shift
            pos.unshift(new_pos.value)
            queue << new_pos.parent
        end
        pos
    end
end

kpf = KnightPathFinder.new([0,0])