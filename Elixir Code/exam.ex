defmodule Exam1 do

  def question1() do

    #[y|_] = [1,2,3] #1
    #y

    #[x,_|y] = [1,2,3] #3
    #y

    #y = [1|y] #error
    #y

    #[x,y,z] = [1|[2,3]] #2
    #y
    #z = 32, x = {:foo, z}, {y, _} = x, y #foo
  end

  #defp new(id, brand, color) do
  #  {:car, id, brand, color}
  #end

  #defp color({:car, id, brand, color}) do
  #  color
  #end

  #defp paint({:car, id, brand, color}, newcolor) do
  #  {:car, id, brand, newcolor}
  #end

  def once([]) do {0, 0} end
  def once(h) do once(h, {0,0}) end
  def once([], {n,m}) do {n, m} end
  def once([h|t], {n,m}) do
    once(t, {n+h, m+1})
  end

  def ack(m,n) when m == 0 do n+1 end
  def ack(m,n) when n == 0 do
      if m > 0 do
        ack(m-1, 1)
      end
  end
  def ack(m, n) when n > 0 do
    if m > 0 do
      ack(m-1, ack(m, n-1))
    end
  end

  def eval([]) do 0 end
  def eval([h1, '+', h2|t]) do
    eval([h1 + h2 | t])
  end
  def eval([h1, '-', h2|t]) do
    eval([h1 - h2 | t])
  end
  def eval(n) do n end

  def isomorfic({:tree, _, _, nil}, {:tree, _, _, nil}) do true end
  def isomorfic({:tree, _, nil, _}, {:tree, _, nil, _}) do true end
  def isomorfic({:tree, _, left, right}, {:tree, _ , left, right}) do
    case isomorfic(right, right) do
      true -> case isomorfic(left,left) do
                true -> true
                false -> false
              end
      false -> false
    end
  end

  def mirror(nil) do nil end
  def mirror({:tree, value, left, right}) do
    mirror({:tree, value, mirror(right), mirror(left)})
  end

  def calc(h, x) do calc(h, x, 0) end
  def calc([], _, res) do res end
  def calc([h|t], x, res) do
    calc(t, x, res*x + h)
  end

  #def collect() do
  #  receive do
  #    contents -> [contents | collect()]
  #    done -> :ok
  #  end
  #end

  def decode(text, tree) do decode(text, tree, tree) end
  def decode([], {:char, char}, _) do [char] end
  def decode([0|t], {:huf, zero, _}, tree) do decode(t,zero,tree) end
  def decode([1|t], {:huf, _, one}, tree) do decode(t, one, tree) end
  def decode(text, {:char, char}, tree) do
    [char | decode(text, text, tree)]
  end

end

defmodule Exam2 do

  def reduce([]) do [] end
  def reduce([h, h|t]) do reduce([h|t]) end
  def reduce([h|t]) do [h|reduce(t)] end

  def encode([]) do [] end
  def encode([32|rest]) do
    [32 | encode(rest)]
  end
  def encode([h|rest]) when h < 100 do
    [h+23|encode(rest)]
  end
  def encode([h|rest]) do
    [h - 3 | encode(rest)]
  end

  #def triss([]) do false end
  #def triss([{:card, _, value}|t]) do
  #  case lists:filter(fn({:card, _, n}) -> n == value end, t) do
  #    [_, _ |_ ] -> true
  #    _ -> triss(h)
  #  end
  #end

  def msort([]) do [] end
  def msort([h]) do [h] end
  def msort(a) do
    {l1, l2} = split(a, [], [])
    merge(msort(l1), msort(l2))
  end

  def split([], left, right) do {left, right} end
  def split([h|t], left, right) do
    split(t, [h | right], left)
  end

  def merge([], right) do right end
  def merge(left, []) do left end
  def merge([h1|t1], [h2,_t2] = right) when h1 < h2 do
    [h1 | merge(t1, right)]
  end
  def merge(left, [h2|t2]) do
    [h2 | merge(left, t2)]
  end


  def heap_to_list(nil) do [] end
  def heap_to_list({:heap, element, left, right}) do
    l = heap_to_list(left)
    r = heap_to_list(right)
    [element | merge(l, r)]
  end



end
