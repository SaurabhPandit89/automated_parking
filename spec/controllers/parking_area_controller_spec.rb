require 'rails_helper'

RSpec.describe ParkingAreaController, :type => :controller do

  describe 'GET #create' do
    it 'redirects to root_path' do
      get :create
      expect(response).to redirect_to(root_path)
    end
    it 'redirects to root_path with flash message' do
      get :create
      expect(response.request.flash[:notice]).to_not be_nil
    end
    it 'creates new parking slot if not present already' do
      resp = ParkingArea.all
      expect(resp).to be_empty
      get :create, capacity: '5'
      expect(response).to redirect_to root_path
    end
    it 'updates parking slot if present already' do
      ParkingArea.create(capacity: '5')
      resp = ParkingArea.all
      expect(resp).to_not be_empty
      get :create, capacity: '6'
      expect(response).to redirect_to root_path
    end
  end

end