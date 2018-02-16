class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  def self.new_from_lookup(ticker_symbol)
    begin
      result = StockQuote::Stock.quote(ticker_symbol)
      price = strip_commas(result.l)
      new(  name: result.name, 
            ticker: result.symbol, 
            last_price: price)
    rescue Exception => e
      return nil
    end
  end

  private

    def self.strip_commas(number)
      number.gsub(',', '')
    end

end
