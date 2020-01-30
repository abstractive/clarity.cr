module Clarity

  class Data #de < Hash(String, Value)

    class Rows
    
      def add(row : Hash(Value, Value))
        Gnosis.debug(@value)
        Gnosis.debug(typeof(@value[:rows]))
        Gnosis.debug(typeof(@value[:index]))
        Gnosis.debug(typeof(@value[:pages]))
        Gnosis.debug(typeof(@value[:count]))
        #de @value[:rows].push(row)
        #de @value[:index] = 1 if @value[:index] == 0
        #de @value[:pages] = 1 if @value[:pages] == 0
        #de @value[:count] += 1
      end

    end

    def clone
      hash = Data.new
      hash.initialize_clone(self)
      hash
    end

    def merge!(value)
      @value.merge!(value)
    end

  end
end
