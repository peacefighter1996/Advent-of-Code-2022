defmodule Aoc22d11Test do
  use ExUnit.Case
  doctest Aoc22d11

  test "example 1 for question 1" do
    assert Aoc22d11.question1(Aoc22d11.data("data/test/day11_1.txt")) == 10605
  end

  test "input result question 1" do
    IO.puts("day 11 question 1: [#{Aoc22d11.question1(Aoc22d11.data("data/input/day11.txt"))}]")
    assert true
  end

  test "example 2 for question 1" do
    assert Aoc22d11.question2(Aoc22d11.data("data/test/day11_1.txt")) == 2713310158
  end

  test "input result question 2" do
    IO.puts("day 11 question 1: [#{Aoc22d11.question2(Aoc22d11.data("data/input/day11.txt"))}]")
    assert true
  end
end
