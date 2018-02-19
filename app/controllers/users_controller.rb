class UsersController < ApplicationController
  
  def my_portfolio
    @user = current_user
    @user_stocks = current_user.stocks
  end

  def my_friends
    @friendships = current_user.friends
  end

  def show
    @user = User.find params[:id]
  end

  def search
    if params[:search_param].present?
      @users = User.search(params[:search_param])
      flash.now[:danger] = 'No results found.' if @users.empty?
    else
      flash.now[:danger] = 'You have entered an empty string'
    end
    respond_to do |format|
      format.js { render partial: 'friends/result' }
    end
  end

end