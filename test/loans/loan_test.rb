require "./test/test_helper"
require "finance_bob/loans/loan"

class LoanTest < Minitest::Test
  def setup
    payload = {
      capital: 100,
      months: 18,
      interest_rate: 3.5,
      deposit: 0
    }

    @loan = Loan.new(payload)
  end

  def test_that_get_capital
    assert @loan.capital.equal?(100)
  end

  def test_that_get_months
    assert @loan.months.equal?(18)
  end

  def test_that_get_interest_rate
    assert @loan.interest_rate.equal?(0.002917)
  end

  def test_that_get_tax_rate
    assert @loan.tax_rate.equal?(0.0)
  end
end
