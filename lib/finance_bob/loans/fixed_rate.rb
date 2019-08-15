require 'finance_bob/loans/loan'

class FixedRate < Loan
  def quotation_report
    missing_data?
    { payments: payments_report }
  end

  def discount_factor
    ( ( (1 + interest_rate) ** months ) - 1 ) / ( interest_rate * (1 + interest_rate) ** months )
  end

  private

  def monthly_payment
    capital / discount_factor
  end

  def monthly_capital(interest)
    monthly_payment - interest
  end

  def monthly_interest(amount)
    amount * interest_rate
  end

  def monthly_tax(interest)
    interest * tax_rate
  end

  def payments_report
    payments = []
    current_date = initial_date
    capital_amount = capital

    months.times do |month|
      interest = monthly_interest(capital_amount)

      payments << {
        number: month + 1,
        due_date: next_date(current_date),
        capital_amount: monthly_capital(interest).round(2),
        interest_amount: interest.round(2),
        tax_amount: monthly_tax(interest).round(2),
        total_amount: (monthly_payment + monthly_tax(interest)).round(2)
      }
      current_date = next_date(current_date)
      capital_amount -= monthly_capital(interest)
    end
    payments
  end
end
