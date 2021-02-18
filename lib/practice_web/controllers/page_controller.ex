defmodule PracticeWeb.PageController do
  use PracticeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def double(conn, %{"x" => x}) do
    {x, _} = Float.parse(x)
    y = Practice.double(x)
    render conn, "double.html", x: x, y: y
  end

  def calc(conn, %{"expr" => expr}) do
    y = Practice.calc(expr)
    render conn, "calc.html", expr: expr, y: y
  end

  def factor(conn, %{"x" => x}) do
    {x, _} = Integer.parse(x)
    y = Enum.join(Enum.map(Practice.factor(x), fn(factor) -> Integer.to_string(factor) end), ",")
    render conn, "factor.html", x: x, y: y
  end

  def palindrome(conn, %{"str" => str}) do
    p = Practice.palindrome?(str)
    render conn, "palindrome.html", str: str, p: p
  end
end
