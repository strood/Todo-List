class TodoBoard
  require_relative "./item.rb"
  require_relative "./list.rb"

  attr_reader :list

  def initialize(label)
    @list = List.new(label)
  end

  def get_command
    print "Enter a command: "
    cmd, *args = gets.chomp.split(" ")
    puts

    case cmd
    when "mktodo"
      self.list.add_item(args[0], args[1], args[2])
      return true
    when "up"
      if args[1]
        self.list.up(args[0].to_i, args[1].to_i)
        return true
      else
        self.list.up(args[0].to_i)
        return true
      end
    when "down"
      if args[1]
        self.list.down(args[0].to_i, args[1].to_i)
        return true
      else
        self.list.down(args[0].to_i)
        return true
      end
    when "swap"
      self.list.swap(args[0].to_i, args[1].to_i)
      return true
    when "sort"
      self.list.sort_by_date!
      return true
    when "priority"
      self.list.print_priority
      return true
    when "print"
      if args[0]
        self.list.print_full_item(args[0].to_i)
        return true
      else
        self.list.print
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
