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
    @user_stocks = @user.stocks
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

  def add_friend
    @friend = User.find(params[:friend])
    # current_user.friends << friend
    current_user.friendships.build(friend_id: @friend.id)
    if current_user.save
      flash[:success] = 'Friend added!'
    else
      flash[:warning] = 'An error occurred.'
    end
      redirect_to my_friends_path
  end

end