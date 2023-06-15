class Admin::HomesController < ApplicationController

  def top
    @cloths = Cloth.all
  end

end
