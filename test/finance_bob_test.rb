require "./test/test_helper"
require 'date'

describe FinanceBob do
  before do
    @finance_bob = FinanceBob
  end

  it "has a version number" do
    value(::FinanceBob::VERSION).wont_be_nil
  end

  describe 'Interest' do
    # P pricipal
    # I Total Interest
    # C capital
    # n time period in years
    # i anual interest

    describe 'Simple' do
      # Formulas: P = C * ( 1 + n * i)
      # I = C * i * n
    end

    describe 'Compuse' do
      # Formula: C = P * ( 1 + i )^n >>> P = C / [ ( 1 + i )^n ]
    end
  end

  describe 'Loans' do
    let(:payload) do
      {
        capital: capital,
        interest_rate: 6,
        initial_date: initial_date,
        months: 360,
        tax_rate: tax_rate,
        deposit: deposit,
        aditional_deposit: aditional_deposit
      }
    end
    let(:capital) { 100_000.00 }
    let(:tax_rate) { 0 }
    let(:deposit) { 0 }
    let(:initial_date) { Date.new(2019, 1, 1) }

    let(:interest_amount) { 2_625.00 }
    let(:tax_amount) { 0.0 }
    let(:total_amount) { 52_625.00 }
    let(:aditional_deposit) { {} }

    describe 'FixedRatePayments' do
      # Formulas:
      # Discount Factor: D = {[(1+i) ^n] - 1} / [ i (1+i) ^ n]
      it 'has respond to fixed rate payment' do
        @finance_bob.must_respond_to :fixed_rate
      end

      describe 'when request for a quotation' do
        describe 'and provide invalid data' do
          it 'retuns an error message' do
            capital = nil

            @finance_bob.fixed_rate(payload).must_raise StandardError
          end
        end

        describe 'without tax rate' do
          let(:quotation_sample) do
            {
              payments: [
                {
                  number: 1,
                  due_date: Date.new(2019, 2, 1),
                  capital_amount: 99.55,
                  interest_amount: 500.00,
                  tax_amount: 0.0,
                  total_amount: 599.55
                },
                {
                  number: 2,
                  due_date: Date.new(2019, 3, 1),
                  capital_amount: 100.05,
                  interest_amount: 499.50,
                  tax_amount: 0.0,
                  total_amount: 599.55
                },
                {
                  number: 360,
                  due_date: Date.new(2049, 1, 1),
                  capital_amount: 596.57,
                  interest_amount: 2.98,
                  tax_amount: 0.0,
                  total_amount: 599.55
                }
              ]
            }
          end

          it 'returns a payments list' do
            quotation = @finance_bob.fixed_rate(payload)

            quotation[:payments][0].must_equal(quotation_sample[:payments][0])
            quotation[:payments][1].must_equal(quotation_sample[:payments][1])
            quotation[:payments][359].must_equal(quotation_sample[:payments][2])
          end
        end

        describe 'with tax rate' do
          let(:quotation_sample) do
            {
              payments: [
                {
                  number: 1,
                  due_date: Date.new(2019, 2, 1),
                  capital_amount: 99.55,
                  interest_amount: 500.00,
                  tax_amount: 80.0,
                  total_amount: 679.55
                },
                {
                  number: 2,
                  due_date: Date.new(2019, 3, 1),
                  capital_amount: 100.05,
                  interest_amount: 499.50,
                  tax_amount: 79.92,
                  total_amount: 679.47
                },
                {
                  number: 360,
                  due_date: Date.new(2049, 1, 1),
                  capital_amount: 596.57,
                  interest_amount: 2.98,
                  tax_amount: 0.48,
                  total_amount: 600.03
                }
              ]
            }
          end

          let(:tax_rate) { 16 }

          it 'returns payments list' do
            quotation = @finance_bob.fixed_rate(payload)

            quotation[:payments][0].must_equal(quotation_sample[:payments][0])
            quotation[:payments][1].must_equal(quotation_sample[:payments][1])
            quotation[:payments][359].must_equal(quotation_sample[:payments][2])
          end
        end
      end
    end

    describe 'Amortization' do
      it 'has respond to amortization' do
        @finance_bob.must_respond_to :amortization
      end

      describe 'when request for a quotation' do
        describe 'with invalid data' do
          it 'retuns an error message' do
          end
        end

        describe 'without tax rate' do
          it 'returns payments list' do
          end

          describe 'and aditional deposits' do
          end
        end

        describe 'with tax rate' do
          it 'returns payments list' do
          end
        end
      end
    end
  end
end
