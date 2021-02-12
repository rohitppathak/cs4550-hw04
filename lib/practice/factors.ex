defmodule Practice.Factors do

  def factor(x) do
    factor(x, 2, [])
  end

  def factor(x, n, factors) when x == 1 do
    factors
  end

  def factor(x, n, factors) do
    if rem(x, n) == 0 do
      factor(div(x, n), n, factors ++ [n])
    else
      factor(x, n + 1, factors)
    end
  end
end
