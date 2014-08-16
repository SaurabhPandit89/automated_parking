class AllotParking < ActiveRecord::Base

  class << self

    def park(reg_no, colour)
      capacity = ParkingArea.first.capacity
      slot_no = get_slot_number(capacity)
      if slot_no.is_a?(String)
        slot_no
      else
        parking_slot = self.create(:slot_number => slot_no, :registration_number => reg_no, :color => colour)
        parking_slot.slot_number
      end
    end

    def status
      self.all
    end

    def regs_no_for_cars_with_color(colour)
      fetch_data_using_color('LOWER(color) LIKE ?', colour, 'registration_number')
    end

    def slot_no_for_cars_with_color(colour)
      fetch_data_using_color('LOWER(color) LIKE ?', colour, 'slot_number')
    end

    def slot_no_for_car_with_regs_no(reg_no)
      fetch_data_using_color('LOWER(registration_number) = ?', reg_no, 'slot_number')
    end

    def leave(slot_no)
      parking_slot = self.find_by(:slot_number => slot_no)
      if parking_slot.blank?
        false
      else
        self.destroy(parking_slot.id)
      end
    end

    def get_slot_number(capacity)
      slot_no = rand(1..capacity)
      if self.where('slot_number = ?', slot_no).blank?
        slot_no
      else
        capacity.eql?(self.all.count) ? 'Sorry, Parking Lot is full !!!' : get_slot_number(capacity)
      end
    end

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
  end

end
