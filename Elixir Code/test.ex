defmodule Test do

IO.puts "Hello world"

  def double(n) do
      2*n
  end

  def fahrenheit(n) do
     (n - 32)/1.8
  end

  def rectangle(a, b) do
    a*b
  end

  def square(a) do
    rectangle(a, a)
  end

  def circle(r) do
    :math.pi*r*r
  end

end

defmodule Recursive do

  def ifproduct(a, b) do
    if a == 0 do
      0
    else
      b + ifproduct(a-1, b)
    end
  end

  def caseproduct(a, b) do
    case a do
      0 ->
        0
      _ ->
        b + caseproduct(a-1, b)
      end
  end

  def product(0, _) do 0 end
  def product(a, b) do
    b + product(a-1,b)
  end

  #def exp(x, y) do
  #  case y do
  #    0 ->
  #      1
  #    _ ->
  #      product(x, exp(x, y-1))
  #  end
  #end

  def exp(_x, 0) do 1 end
  def exp(x, y) do
    product(x, exp(x, y-1))
  end

  def fastexp(x, 1) do x end
  def fastexp(x, y) when rem(y,2) == 0 do
    fastexp(x, div(y, 2))*fastexp(x, div(y, 2))
  end
  def fastexp(x, y) when rem(y,2) == 1 do
    fastexp(x, y-1)*x
  end
end

defmodule Listop do

  def nth(1, [h | _]) do h end
  def nth(n, [_ | t]) do
    nth(n-1, t)
  end

  def len([]) do 0 end
  def len(l) do len(l, 0) end
  def len([], n) do n end
  def len([_h | t], n) do
    len(t, n + 1)
  end

  def sum([]) do 0 end
  def sum(l) do sum(l, 0) end
  def sum([], n) do n end
  def sum([h | t], n) do
    sum(t, n + h)
  end

  def duplicate([]) do [] end
  def duplicate([h | t]) do
    [ h | [h | duplicate(t)]]
  end

  def msort([]) do [] end
  def msort([x]) do [x] end
  def msort(l) do
    {l1, l2} = split(l, [], [])
    merge(msort(l1), msort(l2))
  end

  # Split a list into two equal sized lists using Enum.
  def split([], l1, l2) do {l1, l2} end
  def split([x | tail], l1, l2) do
    split(tail, [x | l2], l1)
  end

  # Merges two list in order by iterating through them one
  # item at time.
  def merge([], l2) do l2 end
  def merge(l1, []) do l1 end
  def merge([x1 | l1], [x2 | _] = l2) when x1 < x2 do
    [x1 | merge(l1, l2)]
  end
  def merge(l1, [x2 | l2]) do
    [x2 | merge(l1, l2)]
  end



end

defmodule Euler do

  def fib(0) do 0 end
  def fib(1) do 1 end
  def fib(n) when n >= 0 do
    fib(n-2) + fib(n-1)
  end
  def fibo(x) do
    for n <- 0..x-1 do
      fib(n)
    end
  end

  def summing(x) do
    List.foldl(fibo(x), 0, fn(y, acc) -> if rem(y, 2) == 0 do
      y + acc
    end end)
  end

end

defmodule Derivative do




end
