require 'singleton'

class ParkingLot
	include Singleton
	attr_accessor :capacity
	attr_accessor :parking_slots

	public
	def create_parking_lot capacity=10
		@capacity = capacity
		@parking_slots = []

		capacity.to_i.times do |i|
			@parking_slots << ParkingSlot.new(i+1)
		end

		puts "Created a parking lot with #{capacity} slots"
	end

	def park registration_number, color
		first_emply_slot = @parking_slots.find{ |slot| slot.is_slot_free == true}
		unless first_emply_slot
			puts "Sorry, parking lot is full"
			return
		end 
		puts "Allocated slot number: #{first_emply_slot.slot_number}"

		car = Car.new(registration_number, color)
		first_emply_slot.car = car
		first_emply_slot.is_slot_free = false;
	end

	def leave slot_number
		puts "Slot number #{slot_number} is free"
		@parking_slots[slot_number.to_i - 1] = ParkingSlot.new(slot_number)
	end

	def status
		puts "Slot No. \t Registration No. \t Color"
        @parking_slots.each do |slot| 
            unless slot.is_slot_free == true
                puts "#{slot.slot_number} \t\t #{slot.car.registration_number} \t\t #{slot.car.color}"
            end
        end
	end

	def registration_numbers_for_cars_with_colour color
        puts @parking_slots.map{|slot| slot.car.registration_number if slot.car.color == color}.compact.join(', ')
    end
    
    def slot_numbers_for_cars_with_colour color
        puts @parking_slots.map{|slot| slot.slot_number if slot.car.color == color}.compact.join(', ')
    end
    
    def slot_number_for_registration_number registration_number
        slot = @parking_slots.find{|slot| (not slot.car.nil? and slot.car.registration_number == registration_number)}
        puts slot.nil? ?  'Not found' : slot.slot_number
    end
end