defmodule Aoc22d6Test do
  use ExUnit.Case
  doctest Aoc22d6

  test "example 1 for question 1" do
    assert Aoc22d6.question1('mjqjpqmgbljsphdztnvjfqwrcgsmlb') == 7
  end

  test "input result question 1" do
    IO.puts("day 6 question 1: [#{Aoc22d6.question1(Aoc22d6.data("data/input/day6.txt"))}]")
    assert true
  end

  test "example 1 for question 2" do
    assert Aoc22d6.question2('mjqjpqmgbljsphdztnvjfqwrcgsmlb') == 19
  end

  test "input result question 2" do
    IO.puts("day 6 question 2: [#{Aoc22d6.question2(Aoc22d6.data("data/input/day6.txt"))}]")
    assert true
  end
end
