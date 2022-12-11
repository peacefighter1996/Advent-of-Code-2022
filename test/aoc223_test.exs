defmodule Aoc223Test do
  use ExUnit.Case
  doctest Aoc22d3

  test "example 1 for question 1" do
    assert Aoc22d3.question1(Aoc22d3.data("data/test/day3_1.txt")) == 157
  end

  test "input result question 1" do
    IO.puts("day 3 question 1: [#{Aoc22d3.question1(Aoc22d3.data("data/input/day3.txt"))}]")
    assert true
  end

  test "example 1 for question 2" do
    assert Aoc22d3.question2(Aoc22d3.data("data/test/day3_1.txt")) == 70
  end

  test "input result question 2" do
    IO.puts("day 3 question 2: [#{Aoc22d3.question2(Aoc22d3.data("data/input/day3.txt"))}]")
    assert true
  end
end
