
defmodule Aoc221Test do
  use ExUnit.Case
  doctest Aoc22d1

  test "example 1 for question 1" do
    assert Aoc22d3.question1(Aoc22d3.data("data/test/day3/1.txt")) == 157
  end

  test "example 1 for question 2" do
    assert Aoc22d3.question2(Aoc22d3.data("data/test/day3/1.txt")) == 70
  end
end
