# frozen_string_literal: true

class PriceHistory
  def self.call(package:, year:, municipality: nil)
    from_date = DateTime.new(year)
    to_date   = from_date.end_of_year

    result = {}

    # { 'Stockholm' => [#Price, #Price], ... }
    price_history = Price.joins(:package, :municipalities)
                         .select('prices.id, prices.price_cents, municipalities.name as m_name')
                         .where(created_at: from_date..to_date, package: { id: package.id })
                         .group_by(&:m_name)

    # filtering by municipality
    if municipality
      prices = price_history[municipality.name]
      result[municipality.name] = prices.map(&:price_cents) if prices
      return result
    end

    price_history.each do |municipality_name, price_array|
      result[municipality_name] = price_array.map(&:price_cents)
    end

    result
  end
end
