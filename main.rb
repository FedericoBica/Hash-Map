require_relative LinkedList

class HashMap 
    
    def initialize
        @bucket = Array.new(16)
        @capacity = 0
        @load_factor = 0.75
    end

    def hash(string)
        hash_code = 0
        prime_num = 31

        string.each_char { |c| hash_code = prime_num * hash_code + c.ord}

        hash_code % @bucket.length
    end

    def set(key, value) 
        key_index = hash(key)

        if @bucket[key_index].nil?
            @bucket[key_index] = Node.new(key, value)
            @capacity += 1
        else
            @bucket[key_index].value = value
        end
        check_capacity
    end

    def get(key)
        key_index = hash(key)

        entry = @bucket[key_index]
        entry.value

    end

    def key?(key)
        key_index = hash(key)
        
        return false if @bucket[key_index].nil?
        true 
    end

    def remove(key)
        key_index = hash(key)

        capacity -= 1
        @bucket[key_index] = nil
    end

    def length
        @capacity
    end

    def clear
        self.initialize
    end

    def keys
        @bucket.reduce([]) { |arr, bucket| arr << bucket.key unless bucket.nil?; arr}
    end

    def values
        @bucket.reduce([]) { |arr, bucket| arr << bucket.value unless bucket.nil?; arr}
    end

    def entries
        keys = self.key
        values = self.value
        arr = []
        @capacity.times do [i]
            arr << [keys[i], values[i]]
        end
        arr
    end

    def check_capacity
        @buckets += Array.new(16) if @capacity > @buckets.length * @load_factor 
    end

end
