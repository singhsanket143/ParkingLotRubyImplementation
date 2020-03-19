#!/usr/bin/env ruby

Dir["./lib/*.rb"].each {|file| require_relative file }

class Script

    def initialize(path = 0)
        @path = path
        @parking_lot = ParkingLot.new 
    end

    def execute command, args
        if command == "create_parking_lot"
            @parking_lot.create_parking_lot(args[0])
        elsif command == 'leave'
            @parking_lot.leave(args[0])
        elsif command == 'park'
            @parking_lot.park(args[0], args[1])
        elsif command == 'registration_numbers_for_cars_with_colour'
            @parking_lot.registration_numbers_for_cars_with_colour(args[0])
        elsif command == 'slot_number_for_registration_number'
            @parking_lot.slot_number_for_registration_number(args[0])
        elsif command == 'slot_numbers_for_cars_with_colour'
            @parking_lot.slot_numbers_for_cars_with_colour(args[0])
        elsif command == 'status'
            @parking_lot.status()
        else
            puts "Invalid command"
        end
    end

    def read_and_execute(inp)
        args = inp.split(' ')
        cmd_name = args[0]
        cmd_args = args[1..inp.length]
        execute cmd_name, cmd_args
    end

    def start(file = '')
        case @path 
            when 0
                while true
                    command = gets().strip 
                    break if command == 'exit'
                    read_and_execute(command)
                end
            when 1 
                commands = File.readlines(file)
                commands.each {|command| read_and_execute(command.strip)}
            else
                puts 'Unknown Input Mode!'
        end
    end
end


file = ARGV[0]
unless file.nil?
    Script.new(1).start(file)
else
    Script.new(0).start
end