class StocksController < ApplicationController

  def search
    if params[:stock].present?
      @stock = Stock.new_from_lookup(params[:stock])
      unless @stock
        flash.now[:warning] = 'You have entered an incorrect symbol.'
      end
    else
      flash.now[:danger] = 'You have entered an empty search.'
    end
    respond_to do |format|
      format.js { render partial: 'users/result' }
    end
  end
  
end