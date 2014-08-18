# Following controller handles the command requests and route it to proper controller.

class CommandWindowController < ApplicationController

  def new
  end

  def execute
    command = params[:command].split(' ').first
    if command.present?
      if command.eql?('create_parking_slot')
        redirect_to create_parking_area_path(:slot => params[:command].split(' ').last)
      else
        command_with_parameter = params[:command].split(' ')
        options = {:command => command_with_parameter.first, :arg1 => command_with_parameter[1]}
        options.merge!({:arg2 => command_with_parameter.last}) if command_with_parameter.count.eql?(3)
        redirect_to assign_command_path(options)
      end
    else
      flash[:notice] = 'Please enter a command !!!'
      redirect_to :root
    end
  end

end
