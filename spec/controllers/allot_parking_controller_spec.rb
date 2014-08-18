require 'rails_helper'

RSpec.describe AllotParkingController, :type => :controller do

  describe 'GET #assign_command' do

    describe 'Calls #park' do
      it 'calls park method to allot a slot' do
        get :assign_command, command: 'park', arg1: 'MH23-KI-7541', arg2: 'Black'
        expect(response).to redirect_to root_path
        expect(response.request.flash[:notice]).to_not be_nil
      end
    end

    describe 'Calls #status' do
      it 'calls status method to show parking lot status' do
        get :assign_command, command: 'status'
        expect(response).to render_template 'allot_parking/status'
      end
    end

    describe 'Calls #leave' do
      it 'calls leave method to release a slot' do
        get :assign_command, command: 'leave', arg1: '3'
        expect(response).to redirect_to root_path
        expect(response.request.flash[:notice]).to_not be_nil
      end
    end

    describe 'Calls #regs_no_for_cars_with_color' do
      it 'calls regs_no_for_cars_with_color method to fetch registration numbers of given color' do
        get :assign_command, command: 'regs_no_for_cars_with_color', arg1: 'white'
        expect(response).to redirect_to root_path
        expect(response.request.flash[:notice]).to_not be_nil
      end
    end

    describe 'Calls #slot_no_for_cars_with_color' do
      it 'calls slot_no_for_cars_with_color method to fetch slot numbers of given color' do
        get :assign_command, command: 'slot_no_for_cars_with_color', arg1: 'white'
        expect(response).to redirect_to root_path
        expect(response.request.flash[:notice]).to_not be_nil
      end
    end

    describe 'Calls #slot_no_for_car_with_regs_no' do
      it 'calls slot_no_for_car_with_regs_no method to fetch slot numbers of given registration number' do
        get :assign_command, command: 'slot_no_for_car_with_regs_no', arg1: 'MH23-KI-7541'
        expect(response).to redirect_to root_path
        expect(response.request.flash[:notice]).to_not be_nil
      end
    end

  end

end