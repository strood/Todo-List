class TodoBoard
  require_relative "./item.rb"
  require_relative "./list.rb"

  attr_reader :lists, :label

  def initialize(label)
    @label = label
    #using a hash so that lsist will be unique keys.
    @lists = {}
    # @list = List.new(label)
  end

  def get_command
    p "           #{self.label.ljust(10)}         "
    p "*Command Format*: <Command> <ListName> <Args>"
    print "Enter a command: "
    cmd, lname, *args = gets.chomp.split(" ")
    puts

    case cmd

    when "mklist"
      self.lists[lname] = List.new(lname)
      return true
    when "mktodo"
      self.lists[lname].add_item(args[0], args[1], args[2])
      return true
    when "up"
      if args[1]
        self.lists[lname].up(args[0].to_i, args[1].to_i)
        return true
      else
        self.lists[lname].up(args[0].to_i)
        return true
      end
    when "down"
      if args[1]
        self.lists[lname].down(args[0].to_i, args[1].to_i)
        return true
      else
        self.lists[lname].down(args[0].to_i)
        return true
      end
    when "swap"
      self.lists[lname].swap(args[0].to_i, args[1].to_i)
      return true
    when "sort"
      self.lists[lname].sort_by_date!
      return true
    when "priority"
      self.lists[lname].print_priority
      return true
    when "ls"
      self.lists.each_key do |label|
        print label.to_s
        puts
      end
      puts
      return true
    when "showall"
      self.lists.each { |label, list| lists[label].print }
      return true
    when "print"
      if args[0]
        self.lists[lname].print_full_item(args[0].to_i)
        return true
      else
        self.lists[lname].print
        return true
      end
    when "toggle"
      self.lists[lname].toggle_item(args[0].to_i)
      return true
    when "rm"
      self.lists[lname].remove_item(args[0].to_i)
    when "rmlist"
      self.lists.delete(lname)
    when "purge"
      if lname
        self.lists[lname].purge
        return true
      else
        self.lists.each_key { |k| lists[k].purge }
        return true
      end
    when "quit"
      return false
    else
      print "Sorry, that command is not recognized."
    end

    true
  end

  def run
    while get_command
      self.get_command
    end
  end
end

b = TodoBoard.new("My Todo Board")

b.run
