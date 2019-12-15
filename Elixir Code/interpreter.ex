defmodule Env do

  def new() do [] end

  def add(id, str, env) do env ++ [{id, str}] end

  def lookup(_, []) do nil end
  def lookup(id, [{x, _} = h | t]) do
    case x == id do
      true -> h
      false ->
        lookup(id, t)
    end
  end

  #def lookup(id, env) do
  #  List.keyfind(env, id, 0)
  #end

  def remove(ids, env) do
    Enum.uniq(env)
    List.keydelete(env, ids, 0)
  end

end

defmodule Eager do

  # function eval expr/2 that takes an expression and an environment and returns
  # either {:ok, str}, where str is a data structure, or :error. An error is returned if the expression can not be evaluated

  def eval_expr({:atm, id}, _) do {:ok, id} end
  def eval_expr({:var, id}, env) do
    case Env.lookup(id, env) do
      nil ->
        :error
      {_, str} ->
        {:ok, str}
    end
  end

  def eval_expr({:cons, head, tail}, env) do
    case eval_expr(head, env) do
      :error -> :error
      {:ok, str} ->
        case eval_expr(tail, env) do
          :error -> :error
          {:ok, ts} ->
            {str, ts}
        end
    end
  end

  # A pattern matching will take a pattern, a data structure and an environment
  # and return either {:ok, env}, where env is an extended environment, or the atom :fail.

  def eval_match(:ignore, _, env) do
    {:ok, env}
  end

  def eval_match({:atm, id}, id, env) do
    {:ok, env}
  end

  def eval_match({:var, id}, str, env) do
    case Env.lookup(id, env) do
      nil ->
        {:ok, Env.add(id, str, env)}
      {_, ^str} ->
        {:ok, env}
      {_, _} ->
        :fail
    end
  end

  #do not understand

  def eval_match({:cons, hp, tp}, [h|t], env) do
    case eval_match(hp, h, env) do
      :fail ->
        :fail
      {:ok, env} ->
        eval_match(tp, t, env)
    end
  end

  def eval_match(_, _, _) do
    :fail
  end

  ### Sequences ###

  def extract_vars([], l) do l end
  def extract_vars([{x, _} = h | t], l) do
    case x == :var do
      true ->
        l ++ h
      false ->
        extract_vars(t, l)
    end
  end

  def eval_seq([exp], env) do
    eval_expr(exp, env)
  end

  #def eval_seq([{:match, ptr, exp} | seq], env) do
  #  case eval_expr(exp, env) do
  #    :error -> :error
  #    ... ->
  #      vars = extract_vars(...)
  #      env = Env.remove(vars, ...)
  #      case eval_match(:cons, str, env) do
  #        :fail ->
  #          :error
  #        {:ok, env} ->
  #          eval_seq(str, env)
  #      end
  #  end
  #end

  def eval(seq) do
    eval_seq(seq, Env.new())
  end

  #seq = [{:match, {:var, :x}, {:atm,:a}},
  #      {:match, {:var, :y}, {:cons, {:var, :x}, {:atm, :b}}},
  #      {:match, {:cons, :ignore, {:var, :z}}, {:var, :y}},
  #      {:var, z}]





end
