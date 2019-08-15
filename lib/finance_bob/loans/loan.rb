require 'date'

class Loan
  def initialize(payload)
    @payload = payload
  end

  def capital
    @capital ||= @payload[:capital] || 0.0
  end

  def months
    @months ||= @payload[:months] || 0.0
  end

  def initial_date
    @initial_date = @payload[:initial_date] || Date.today
  end

  def interest_rate
    @interest_rate ||= ((monthly_interest_rate || 0.0) / 100).round(6) # monthly interest in percentage
  end

  def tax_rate
    @tax_rate ||= (@payload[:tax_rate] || 0.0) / 100.0
  end

  private

  def monthly_interest_rate
    @payload[:interest_rate] / 12.00
  end

  def missing_data?
    errors = {}
    errors[:payload] = 'No payload provided' if @payload.nil?
    raise StandarError if errors.any?
  end

  def next_date(current_date)
    next_month = current_date.month < 12 && current_date.month + 1 || 1
    next_year = current_date.month < 12 && current_date.year || current_date.year + 1

    Date.new(next_year, next_month, current_date.day)
  end
end
