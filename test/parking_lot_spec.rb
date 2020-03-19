require 'RSpec'
require 'singleton'
require_relative '../lib/parking_lot.rb'
require_relative '../lib/parking_slot.rb'
require_relative '../lib/car.rb'

# Dir["../lib/*.rb"].each {|file| require_relative file }

# puts Dir["../lib"]
RSpec.describe ParkingLot.instance do
    parking_lot = ParkingLot.instance

    describe '#create_parking_lot' do
      it 'should create parking lots of provided capacity' do
  
        parking_lot.create_parking_lot(6)

        expect(parking_lot.capacity).to eq(6)
        expect(parking_lot.parking_slots.length).to eq(6)
        expect(parking_lot.parking_slots.first).to be_an_instance_of(ParkingSlot)
      end
    end
  
    describe '#park' do
      it 'should create a car and park car in the first available slot' do
        parking_lot.create_parking_lot(5)
  
        expect(parking_lot).to receive(:puts).with('Allocated slot number: 1')
        parking_lot.park('test-num-A','black')
  
        expect(parking_lot.parking_slots.first.car.registration_number).to eq('test-num-A')
        expect(parking_lot.parking_slots.first.car.color).to eq('black')
        expect(parking_lot.parking_slots.last.car).to be_nil
      end
      it 'should not create and park car if parking full' do
  
        parking_lot.create_parking_lot(1)
  
        expect(parking_lot).to receive(:puts).with('Allocated slot number: 1')
        parking_lot.park('num-A','black')
  
        expect(parking_lot).to receive(:puts).with('Sorry, parking lot is full')
        parking_lot.park('KA-01-1235','black')
      end
    end
  
    describe '#leave' do
      it 'should free the provided parking slot' do
  
        parking_lot.create_parking_lot(1)
        expect(parking_lot.parking_slots.last.car).to be_nil
  
        parking_lot.park('test-num-A','black')
        expect(parking_lot.parking_slots.last.car).to_not be_nil
  
        parking_lot.leave(1)
        expect(parking_lot.parking_slots.last.car).to be_nil
      end
    end
  
    describe '#data fetch and print' do
      it 'should fetch and print registration_numbers_for_cars_with_colour' do
        parking_lot = prefilled_parking_lot
  
        expect(parking_lot).to receive(:puts).with('test-num-B, test-num-D')
  
        parking_lot.registration_numbers_for_cars_with_colour('silver')
      end

      it 'should fetch and print slot_numbers_for_cars_with_colour' do
        parking_lot = prefilled_parking_lot
  
        expect(parking_lot).to receive(:puts).with('1, 3')
        parking_lot.slot_numbers_for_cars_with_colour('black')
      end
  
      it 'should fetch and print slot_number_for_registration_number' do
        parking_lot = prefilled_parking_lot
        expect(parking_lot).to receive(:puts).with(2)
        parking_lot.slot_number_for_registration_number('test-num-B')
      end
  
      it 'should fetch and print Not Found when slot_number_for_registration_number is not present' do
        parking_lot = prefilled_parking_lot
  
        expect(parking_lot).to receive(:puts).with('Not found')
        parking_lot.slot_number_for_registration_number('some-test-num')
      end
  
      it 'should fetch and print the status of the parking lot' do
        parking_lot = prefilled_parking_lot
  
        expect(parking_lot).to receive(:puts).with("Slot No. \t Registration No. \t Color")
        expect(parking_lot).to receive(:puts).with("1 \t\t test-num-A \t\t black")
        expect(parking_lot).to receive(:puts).with("2 \t\t test-num-B \t\t silver")
        expect(parking_lot).to receive(:puts).with("3 \t\t test-num-C \t\t black")
        expect(parking_lot).to receive(:puts).with("4 \t\t test-num-D \t\t silver")
  
        parking_lot.status
      end
    end
  
    def prefilled_parking_lot
      parking_lot = ParkingLot.instance
      parking_lot.create_parking_lot(4)
  
      parking_lot.park('test-num-A','black')
      parking_lot.park('test-num-B','silver')
      parking_lot.park('test-num-C','black')
      parking_lot.park('test-num-D','silver')
  
      return parking_lot
    end
  end