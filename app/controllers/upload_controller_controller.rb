class UploadController < ApplicationController
  def index
  end

  def import
    rowarray = Array.new
    myfile = params[:file]
    @rowarraydisp = CSV.read(myfile.path)
  end
end
