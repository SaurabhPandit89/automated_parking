require 'rails_helper'

RSpec.describe CommandWindowController, :type => :controller do

  describe 'GET #new' do
    it 'responds successfully with an HTTP 200 status code' do
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    it 'renders the new template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'POST #execute' do

    describe 'COMMAND #create parking slot' do
      it 'redirects to create_parking_area_path with command parameter' do
        post :execute, command: 'create_parking_slot 5'
        expect(response).to redirect_to(create_parking_area_path(slot: '5'))
      end
    end

    describe 'COMMAND #park' do
      it 'redirects to assign_command_path with park as a command' do
        post :execute, command: 'park MH37-AR-4215 Black'
        expect(response).to redirect_to(assign_command_path({command: 'park', arg1: 'MH37-AR-4215', arg2: 'Black'}))
      end
    end

    describe 'COMMAND #status' do
      it 'redirects to assign_command_path with status as a command' do
        post :execute, command: 'status'
        expect(response).to redirect_to(assign_command_path({command: 'status'}))
      end
    end

    describe 'COMMAND #leave' do
      it 'redirects to assign_command_path with leave as a command' do
        post :execute, command: 'leave 4'
        expect(response).to redirect_to(assign_command_path({command: 'leave', arg1: '4'}))
      end
    end

    describe 'COMMAND #regs_no_for_cars_with_color' do
      it 'redirects to assign_command_path with regs_no_for_cars_with_color as a command' do
        post :execute, command: 'regs_no_for_cars_with_color black'
        expect(response).to redirect_to(assign_command_path({command: 'regs_no_for_cars_with_color', arg1: 'black'}))
      end
    end

    describe 'COMMAND #slot_no_for_cars_with_color' do
      it 'redirects to assign_command_path with slot_no_for_cars_with_color as a command' do
        post :execute, command: 'slot_no_for_cars_with_color black'
        expect(response).to redirect_to(assign_command_path({command: 'slot_no_for_cars_with_color', arg1: 'black'}))
      end
    end

    describe 'COMMAND #slot_no_for_car_with_regs_no' do
      it 'redirects to assign_command_path with slot_no_for_car_with_regs_no as a command' do
        post :execute, command: 'slot_no_for_car_with_regs_no MH37-AR-4215'
        expect(response).to redirect_to(assign_command_path({command: 'slot_no_for_car_with_regs_no', arg1: 'MH37-AR-4215'}))
      end
    end

    describe 'No command is passed' do
      it 'redirects to root_path with a message' do
        post :execute, command: ''
        expect(response).to redirect_to(root_path)
        expect(response.request.flash[:notice]).to_not be_nil
      end
    end

  end

end