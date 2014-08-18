# Following controller does the functinality of alloting the parking space for the cars.

class AllotParkingController < ApplicationController

  def assign_command
    begin
      eval("#{params[:command]}")
    rescue Exception => e
      flash[:notice] = "Invalid command '#{params[:command]}!!!"
      redirect_to :root
    end
  end

  private

  def park
    slot_no = AllotParking.park(params[:arg1], params[:arg2])
    flash[:notice] = if slot_no.is_a?(String)
                       slot_no
                     else
                       "Allotted parking slot number : #{slot_no}  !!!"
                     end
    redirect_to :root
  end

  def status
    @status = AllotParking.status
    render 'allot_parking/status'
  end

  def leave
    flash[:notice] = if AllotParking.leave(params[:arg1])
                       "Slot number #{params[:arg1]} is free"
                     else
                       "Could not leave as slot number #{params[:arg1]} is already free !!!"
                     end
    redirect_to :root
  end

  def regs_no_for_cars_with_color
    flash[:notice] = AllotParking.regs_no_for_cars_with_color(params[:arg1])
    redirect_to :root
  end

  def slot_no_for_cars_with_color
    flash[:notice] = AllotParking.slot_no_for_cars_with_color(params[:arg1])
    redirect_to :root
  end

  def slot_no_for_car_with_regs_no
    flash[:notice] = AllotParking.slot_no_for_car_with_regs_no(params[:arg1])
    redirect_to :root
  end

end
