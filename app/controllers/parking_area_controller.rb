class ParkingAreaController < ApplicationController

  def create
    response = if ParkingArea.all.blank?
      ParkingArea.create(:capacity => params[:slot])
    else
      ParkingArea.update(ParkingArea.first.id, :capacity => params[:slot])
    end
    flash[:notice] =  response.valid? ? "Created Parking lot with #{params[:slot]} slots!!!" : 'Error creating parking slot !!!'
    redirect_to :root
  end

end
