module Algorithm
  class PriorityQueue
    attr_reader :size

    def initialize(order: :asc)
      @size = 0
      @nodes = []
      @operator = (order == :asc)? [:>, :<] : [:<, :>]
    end

    def empty?
      @size.zero?
    end

    def push(node)
      if @nodes[0].nil?
        @nodes[0] = node
      else
        index = size
        @nodes[index] = node

        loop {
          parent = (index-1)/2

          if (@nodes[parent].last <=> node.last).public_send(@operator.first, 0)
            @nodes[index], @nodes[parent] = @nodes[parent], @nodes[index]
            index = parent

            break if index.zero?
          else
            break
          end
        }
      end

      @size += 1
    end
    alias_method :<<, :push

    def pop
      node = @nodes.first
      @nodes[0], @nodes[size - 1] = @nodes[size - 1], nil
      index = 0

      loop {
        left = 2*index+1
        right = 2*index+2

        if @nodes[left].nil? && @nodes[right].nil?
          break
        elsif @nodes[right].nil? && @nodes[left]
          @nodes[index], @nodes[left] = @nodes[left], @nodes[index]
          index = left
        elsif @nodes[left].nil? && @nodes[right]
          @nodes[index], @nodes[right] = @nodes[right], @nodes[index]
          index = right
        elsif (@nodes[left].last <=> @nodes[right].last).public_send(@operator.last, 0)
          @nodes[index], @nodes[left] = @nodes[left], @nodes[index]
          index = left
        else
          @nodes[index], @nodes[right] = @nodes[right], @nodes[index]
          index = right
        end
      }

      @size -= 1
      node.first
    end

    def top
      @nodes.first
    end
  end
end