defmodule Practice.Palindrome do

  def palindrome?(str) do
    str
    |> String.downcase()
    |> String.to_charlist()
    |> Enum.reverse()
    |> to_string()
    |> (fn(s) -> s == String.downcase(str) end).()
  end
end
