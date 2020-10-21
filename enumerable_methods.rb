# Using enumerable module
module Enumerable
  def my_each
    i = 0
    until i == size
      yield self[i]
      i += 1
    end
    self
  end

  def my_each_with_index
    i = 0
    until i == size
      yield self[i], i
      i += 1
    end
    self
  end

  def my_select
    array = []
    my_each { |item| array << item if yield item }
    array
  end

  def my_all?
    condition = true
    if block_given?
      my_each do |item|
        if (yield item) == false
          condition = false
          break
        end
        condition
      end
    end
    condition
  end

  def my_any?
    condition = false
    if block_given?
      my_each do |item|
        if (yield item) == true
          condition = true
          break
        end
        condition
      end
    end
    condition
  end

  def my_none?
    condition = true
    if block_given?
      my_each do |item|
        if (yield item) == false
          condition = false
          break
        end
       !condition
      end
    end
    condition
  end

  def my_count
  
     counter = 0
     if block_given?
      my_each { |item| counter +=1 if yield (item) }
      array
     end

     def my_map (proc = nil)
      array = []
      if block_given
        my_each {|item| array << yield(item)}
      else 
        my_each{|item| array << proc.call(item)}
       
      end
      array
    end

      def my_inject

  end

p (%w[err hjk].my_none? { |word| word.length.nil? })
