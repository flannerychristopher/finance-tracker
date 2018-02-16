class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  cattr_accessor :current_user

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships

  def full_name
    if (first_name || last_name)
      "#{first_name} #{last_name}".strip
    else
      "anonymous"
    end
  end

  def stock_already_added?(ticker_symbol)
    stock = Stock.find_by_ticker(ticker_symbol)
    # current_user.stocks.include? stock ? true : false
    return false unless stock
    user_stocks.where(stock_id: stock.id, user_id: current_user.id).exists?
  end

  def over_stock_limit?
    stock_count > 9
  end
  
  def can_add_stock?(ticker_symbol)
    return true unless over_stock_limit? or stock_already_added?(ticker_symbol)
  end

  private 

    def stock_count
      user_stocks.where(user_id: current_user.id).count
    end

end

