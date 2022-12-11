defmodule Monkey do
  defstruct [:items,
    :index,
    :opperation,
    :devidor,
    :test_value,
    :true_index,
    :false_index,
    :activity]

  def get_split_items(monkey) do
    items = Map.fetch!(monkey,:items)
    splitItems= Enum.map(items, fn x -> throw_to(monkey,x) end)
    monkeystate = Map.replace!(monkey, :activity, Map.fetch!(monkey, :activity) + length(items))
    |> Map.replace!(:items, [])
    {splitItems, monkeystate}
  end

  def throw_to(monkey,x) do
    execute(Map.fetch!(monkey, :opperation),x,Map.fetch!(monkey,:devidor),Map.fetch!(monkey,:test_value))
  end
  def opperation(value, nil, testvalue) do
    devided = div(value,3)
    {rem(devided,testvalue) == 0,devided}
  end
  def opperation(value, devidor, testvalue) do
    devided = rem(value,devidor)
    {rem(devided,testvalue) == 0,devided}
  end
  def execute([o, y],value,devidor,testvalue) do
    case o do
      '+' -> opperation(value + y, devidor, testvalue)
      '*' -> opperation(value * y, devidor, testvalue)
      '^' -> opperation(value * value, devidor, testvalue)
      true -> throw("unknown opperation")
    end
  end
  def execute(_,_, _,_) do
    throw("unknown opperation")
  end
end



defmodule Aoc22d11 do
  @moduledoc """
  Module for solving the questions of day 11 of Advent of Code 2022.
  """

  @doc """
  Get the input data from the data/input_day11.txt file.
  """
  def data do
    data("data/input/day11.txt")
  end

  def data(file) do
    {:ok, data} = File.read(file)
    data = String.split(data, "\r\n\r\n")
    |> Enum.map(fn x -> String.split(x,"\r\n") end)
    |> Enum.map(fn x -> Enum.map(x, fn y -> String.split(y," ") end) end)
    Enum.map(0..length(data)-1, fn x -> monkey_time(Enum.at(data,x),x) end)
    |> Enum.reverse
  end

  def monkey_time(data,n) do
    values = Enum.at(data,1) |> Enum.drop(4) |> Enum.map(fn k -> String.trim(k, ",")|> String.to_integer end)
    oppration = Enum.at(data,2) |> Enum.drop(6)
    oppration = if Enum.at(oppration,1) == "old", do: ['^',2], else: [String.to_charlist(Enum.at(oppration,0)), String.to_integer(Enum.at(oppration,1))]
    test = Enum.at(data,3) |> Enum.at(5) |> String.to_integer
    %Monkey{}
    |> Map.put(:items, values)
    |> Map.put(:index, n)
    |> Map.put(:opperation, oppration)
    |> Map.put(:test_value, test)
    |> Map.put(:true_index, Enum.at(data,4) |> Enum.at(9) |> String.to_integer)
    |> Map.put(:false_index, Enum.at(data,5) |> Enum.at(9) |> String.to_integer)
    |> Map.put(:activity, 0)
  end

  def question1() do
    question1(data())
  end
  def question1(data) do
    len = length(data)-1
    #monkeys = data |> Enum.map(fn x -> Map.put(x,:devidor,3) end)
    Enum.reduce(1..20, data, fn (_, acc) ->execute_round(acc,len) end)
    |> Enum.sort_by(fn x -> Map.fetch!(x, :activity) end, :desc)
    |> Enum.take(2)
    |> Enum.map(fn x -> Map.fetch!(x, :activity) end)
    |> Enum.reduce(1, fn x, acc -> acc * x end)
  end



  def update(monkeys, index, monkey) do
    Enum.map(0..length(monkeys)-1, fn x -> if x == index, do: monkey, else: Enum.at(monkeys,x) end)
  end

  def update_list(monkeys, index, list) do
    monkey = Enum.at(monkeys,index)
    monkey = Map.replace!(monkey, :items, Map.fetch!(monkey, :items) ++ list)
    update(monkeys, index, monkey)
  end

  def execute_round(monkeys,-1) do
    #IO.inspect(monkeys)
    monkeys
  end

  def execute_round(monkeys, index) do
    #IO.inspect({monkeys, index})
    {splitItems, monkey} = Monkey.get_split_items(Enum.at(monkeys,index))
    true_monkey_list = Enum.filter(splitItems, fn x -> elem(x,0) end) |> Enum.map(fn x -> elem(x,1) end)
    true_monkey_index = Map.fetch!(monkey, :true_index)
    false_monkey_list = Enum.filter(splitItems, fn x -> not elem(x,0) end) |> Enum.map(fn x -> elem(x,1) end)
    false_monkey_index = Map.fetch!(monkey, :false_index)

    new_list = update(monkeys, index, monkey)
              |> update_list( length(monkeys)-1 -true_monkey_index, true_monkey_list)
              |> update_list( length(monkeys)-1 -false_monkey_index, false_monkey_list)
    execute_round(new_list , index-1)
  end

  @doc """
  result of question 2
  """
  def question2() do
    question2(data())
  end
  def question2(data) do
    len = length(data)-1
    common_dividor = Enum.reduce(data, 1, fn x,acc -> acc* Map.fetch!(x,:test_value) end)
    monkeys = Enum.map(data, fn x -> Map.replace!(x, :devidor, common_dividor) end)

    Enum.reduce(1..10_000, monkeys, fn (_, acc)  -> execute_round(acc,len) end)
    |> Enum.sort_by(fn x -> Map.fetch!(x, :activity) end, :desc)
    |> Enum.take(2)
    |> Enum.map(fn x -> Map.fetch!(x, :activity) end)
    |> Enum.reduce(1, fn x, acc -> acc * x end)
  end



end
