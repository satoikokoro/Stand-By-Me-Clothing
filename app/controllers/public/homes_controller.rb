class Public::HomesController < ApplicationController
  def top
    @cloth = Cloth.new
    @clothes = Cloth.all
  end
    
  
end
