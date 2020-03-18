class ParkingSlot
	private :is_slot_free
	private :car
	private :slot_number
	
	# Constructor
	def initialize slot_number
		@slot_number = slot_number
		@is_slot_free = true
		@car = nil
	end

	# Function to allot a car to a particular parking slot
	def allot_car car
		@car = car
		@is_slot_free = false
	end

	# Function to remove a car to a particular parking slot
	def remove_car
		@car = nil
		@is_slot_free = true
	end

	attr_reader :is_slot_free, :slot_number
end