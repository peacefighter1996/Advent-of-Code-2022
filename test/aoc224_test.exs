defmodule Aoc22d4Test do
  use ExUnit.Case
  doctest Aoc22d4

  test "example 1 for question 1" do
    assert Aoc22d4.question1(Aoc22d4.data("data/test/day4_1.txt")) == 2
  end

  test "input result question 1" do
    IO.puts("day 4 question 1: [#{Aoc22d4.question1(Aoc22d4.data("data/input/day4.txt"))}]")
    assert true
  end

  test "input result question 2" do
    IO.puts("day 4 question 2: [#{Aoc22d4.question2(Aoc22d4.data("data/input/day4.txt"))}]")
    assert true
  end

  test "example 1 for question 2" do
    assert Aoc22d4.question2(Aoc22d4.data("data/test/day4_1.txt")) == 4
  end
end
