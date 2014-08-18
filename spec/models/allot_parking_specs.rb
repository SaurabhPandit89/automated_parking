require 'rails_helper'

RSpec.describe AllotParking, :type => :model do

  describe 'AllotParking #park' do
    it 'allots a parking slot' do
      expect(AllotParking.park('MH08-YT-7412', 'Blue').class).to must_equal Integer
    end
    it 'should not allot parking if error occurs' do
      expect(AllotParking.park('MH08-YT-7412')).to must_equal 'Error creating parking slot !!!'
    end
  end

end
