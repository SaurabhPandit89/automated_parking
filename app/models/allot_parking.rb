# Class AllotParking is responsible for following things:
# 1. Alloting parking slot for new cars entering the parking slot [park(reg_no, colour)]
# 2. To find the current status of parking area [status]
# 3. To find the registration numbers of the cars with given color [regs_no_for_cars_with_color(colour)]
# 4. To find the slot numbers of the cars with given color [slot_no_for_cars_with_color(colour)]
# 5. To find the slot number of the car with given registration number [slot_no_for_car_with_regs_no(reg_no)]
# 6. To release the parking slot. [leave(slot_no)]

class AllotParking < ActiveRecord::Base

  validates :slot_number,
            :presence => true,
            :numericality => true

  validates :registration_number,
            :presence => true

  validates :color,
            :presence => true

  class << self

    # Method to Allot parking slot for the cars
    def park(reg_no, colour)
      capacity = ParkingArea.first.capacity
      slot_no = get_slot_number(capacity)
      if slot_no.is_a?(String)
        slot_no
      else
        parking_slot = self.create(:slot_number => slot_no, :registration_number => reg_no, :color => colour)
        parking_slot.valid? ? parking_slot.slot_number : display_errors(parking_slot.errors.messages)
      end
    end

    # Method to return the current stats of the parking area
    def status
      self.all
    end

    # Method to find the registration numbers of all the cars with given color
    def regs_no_for_cars_with_color(colour)
      fetch_data_using_color('LOWER(color) LIKE ?', colour, 'registration_number')
    end

    # Method to find the slot numbers of all the cars with given color
    def slot_no_for_cars_with_color(colour)
      fetch_data_using_color('LOWER(color) LIKE ?', colour, 'slot_number')
    end

    # Method to find the slot number of car with given slot number
    def slot_no_for_car_with_regs_no(reg_no)
      fetch_data_using_color('LOWER(registration_number) = ?', reg_no, 'slot_number')
    end

    # Method to release or free the alloted parking slot
    def leave(slot_no)
      parking_slot = self.find_by(:slot_number => slot_no)
      if parking_slot.blank?
        false
      else
        self.destroy(parking_slot.id)
      end
    end

    # Method to find the free slot in the parking area, it returns the slot number to allot parking slot
    # to new cars entering the parking area
    def get_slot_number(capacity)
      total_slots = (1..capacity).step(1).to_a
      occupied_slots = self.select(:slot_number).collect{|record| record.slot_number}.sort
      available_slots = total_slots - occupied_slots
      available_slots.blank? ? 'Sorry, Parking Lot is full !!!' : available_slots.sort.first
    end

    # A common method to retreive data for following 3 methods :
    # 1. regs_no_for_cars_with_color (color)
    # 2. slot_no_for_cars_with_color (color)
    # 3. slot_no_for_car_with_regs_no (reg_no)
    def fetch_data_using_color(query, data, attrib)
      records = self.where(query, data.downcase)
      if records.blank?
        'Not Found !!!'
      else
        numbers = ''
        records.each {|record| numbers << ' ' + eval("record.#{attrib}.to_s") + ','}
        numbers.chop
      end
    end

    def display_errors(errors={})
      error_messages = ''
      errors.each {|key, value| error_messages << "[#{key} : #{value.first}] "}
      error_messages
    end

  end

end
