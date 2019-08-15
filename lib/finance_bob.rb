require "finance_bob/version"
require "finance_bob/loans/fixed_rate"
require "finance_bob/loans/amortization"

module FinanceBob
  class Error < StandardError; end

  def self.fixed_rate(payload)
    fixed_rate = FixedRate.new(payload)
    fixed_rate.quotation_report
  end

  def self.amortization(payload)
    amortization = Amortization.new(payload)
    amortization.quotation_report
  end
end

####################
# FinancialBob
# - Loans
#  -- Fixed-Rate Payments
#    --- Discount Factor
#    --- Loan Payment aka interest per month
#    --- Monthly Payment
#  -- Amortization
####################
