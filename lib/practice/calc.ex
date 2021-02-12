defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  def tag_token(token) do
    precedence = %{"+" => 1, "-" => 1, "*" => 2, "/" => 2}
    if token in ["+", "-", "*", "/"] do
      {:op, token, :value, precedence[token]}
    else
      {val, _} = Float.parse(token)
      {:num, val}
    end
  end

  def tag_tokens(tokens) do
    Enum.map(Enum.filter(tokens, fn(token) -> token !== "" end), fn(token) -> tag_token(token) end)
  end

  def postfix(tokens, output \\ [], stack \\ []) do
    case {tokens, output, stack} do
      {[], output, []} -> output
      {[], output, [head | tail]} -> postfix([], [head | output], tail)
      {[{:num, token} | tail], output, stack} -> postfix(tail, [{:num, token} | output], stack)
      {[{:op, token, :value, value} | tail], output, []} -> postfix(tail, output, [{:op, token, :value, value}])
      {[{:op, token, :value, value} | tail], output, [{:op, last_token, :value, last_value} | stack_tail]} ->
        if value > last_value do
          postfix(tail, output, [{:op, token, :value, value} | stack])
        else
          postfix(tokens, [{:op, last_token, :value, last_value} | output], stack_tail)
        end
    end
  end

  def evaluate(tokens, stack \\ []) do
    case {tokens, stack} do
      {[], []} -> 0
      {[], [token | _]} -> token
      {[{:num, token} | tail], stack} -> evaluate(tail, [token | stack])
      {[{:op, token, :value, _} | tail], [val1 | [val2 | stack_tail]]} ->
        cond do
          token == "+" -> evaluate(tail, [val2 + val1 | stack_tail])
          token == "-" -> evaluate(tail, [val2 - val1 | stack_tail])
          token == "*" -> evaluate(tail, [val2 * val1 | stack_tail])
          token == "/" -> evaluate(tail, [val2 / val1 | stack_tail])
        end
      _ -> "invalid"
    end
  end

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations
    expr
    |> String.split(~r/\s+/)
    |> tag_tokens
    |> postfix
    |> Enum.reverse
    |> evaluate
  end
end
