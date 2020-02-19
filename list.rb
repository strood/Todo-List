class List
  require_relative "./item.rb"
  attr_reader :label, :items
  attr_writer :label

  def initialize(label)
    @label = label
    @items = []
  end

  def add_item(title, deadline, description = "")
    if Item.valid_date?(deadline)
      new_item = Item.new(title, deadline, description)
      self.items << new_item
      return true
    else
      return false
    end
  end

  def remove_item(index)
    if self.valid_index?(index)
      self.items.delete_at(index)
      return true
    else
      return false
    end
  end

  def purge
    self.items.each.with_index do |item, index|
      if item.done
        self.remove_item(index)
      end
    end
  end

  def size
    self.items.length
  end

  #made as an instance method, not class method as it pertains to a specific class instance
  def valid_index?(index)
    return true if index < self.items.length
    false
  end

  def swap(index_1, index_2)
    if valid_index?(index_1) && valid_index?(index_2)
      self.items[index_1], self.items[index_2] = self.items[index_2], self.items[index_1]
      return true
    end
    false
  end

  def [](index)
    return self.items[index] if valid_index?(index)
  end

  def priority
    self[0]
  end

  def print
    p "------------------------------------------------------"
    p "            #{self.label.upcase.ljust(15)}  "
    p "------------------------------------------------------"
    p "Index |  Item                     | Deadline     | Done     "
    p "------------------------------------------------------"
    self.items.each.with_index do |item, i|
      p " #{i.to_s.ljust(5)}| #{item.title.ljust(26)}| #{item.deadline.ljust(1)}   | [#{"✓" if item.done}] "
    end
    p "------------------------------------------------------"
    true
  end

  def print_full_item(index)
    if valid_index?(index)
      p "------------------------------------------------------"
      p "#{self[index].title.to_s.ljust(15).upcase}   #{self[index].deadline.to_s.ljust(15)}[#{"✓" if self[index].done}]".ljust(10)
      p "#{self[index].description.to_s.ljust(50)} "
      p "------------------------------------------------------"
      true
    else
      false
    end
  end

  def print_priority
    self.print_full_item(0)
  end

  def up(index, amount = 1)
    if self.valid_index?(index)
      while index > 0 && amount > 0
        self.items[index], self.items[index - 1] = self.items[index - 1], self.items[index]
        index -= 1
        amount -= 1
      end

      return true
    else
      return false
    end
  end

  def down(index, amount = 1)
    if self.valid_index?(index)
      while index < self.items.length - 1 && amount > 0
        self.items[index], self.items[index + 1] = self.items[index + 1], self.items[index]
        index += 1
        amount -= 1
      end

      return true
    else
      return false
    end
  end

  def sort_by_date!
    self.items.sort_by! { |item| item.deadline }
  end

  def toggle_item(index)
    self.items[index].toggle
  end
end
