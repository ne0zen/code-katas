#!/usr/bin/env bacon

# making change for an amount
# optionally given a set of coins

# simple recursive greedy implementation which shortcuts out of the each
# (coins are expected to be passed in from largest to smallest)
def make_change(n, coins=[25,10,5,1])
  coins.each do |c|
    next if c > n
    if n - c == 0
      return [c]
    elsif n - c > 0
      return [c] + make_change(n-c, coins)
    end
  end

  raise "couldn't find change"
end

describe "#make_change" do
  it "should make change for 1" do
    make_change(1).should == [1]
  end

  it "should make_change for 2" do
    make_change(2).should == [1,1]
  end

  it "should make change for 6" do
    make_change(6).should == [5,1]
  end

  it "should make change for 51" do
    make_change(51).should == [25,25,1]
  end

  it "should make change for 99" do
    make_change(99).should == [25, 25, 25, 10, 10, 1, 1, 1, 1]
  end

  it "should make_change in canadian" do
    make_change(500, [200, 100, 25,10,5,1]).should == [200,200,100]
  end
end


