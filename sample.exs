IO.puts "----"


doll_hairs = fn(number) -> :erlang.float_to_binary(number, [decimals: 2]) end

loan_amount = 120000
interest_rate_for_loan = 0.04
monthly_interest_rate = interest_rate_for_loan/12
sp_return = 0.07
length_of_loan = 240
age_at_retirement = 52.0
age_of_death = 78.69
additional_income = 40000.0

benifit_from_buying_years = (age_of_death - age_at_retirement) * additional_income


IO.puts "benifit from buying years: #{doll_hairs.(benifit_from_buying_years)}"


cost_of_borrowing_money = (monthly_interest_rate * loan_amount * length_of_loan)/(1 - :math.pow((1+monthly_interest_rate), (-1 * length_of_loan)))
IO.puts "cost of borrowing money years #{doll_hairs.(cost_of_borrowing_money)}"
IO.puts "profit of buying years #{doll_hairs.(benifit_from_buying_years - cost_of_borrowing_money)}"


benifit_of_sp500 = loan_amount*:math.pow((1+sp_return), 20)


IO.puts "benifit from average stock market return: #{doll_hairs.(benifit_of_sp500)}"
