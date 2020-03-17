class Car
	private :registration_number
	private :color

	def initialize registration_number, color
		@registration_number = registration_number
		@color = color
	end

	attr_reader :registration_number, :color
end