class StocksController < ApplicationController

  def search
    if params[:stock].present?
      @stock = Stock.new_from_lookup(params[:stock])
      # render json: @stock
      flash[:warning] = 'You have entered an incorrect symbol.' unless @stock
      render 'users/my_portfolio'
    else
      flash.now[:danger] = 'You have entered an empty search'
      redirect_to my_portfolio_path
    end
  end

end