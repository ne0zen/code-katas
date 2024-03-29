#!/usr/bin/env testrb

# see http://codekata.pragprog.com/2007/01/kata_nine_back_.html

require './checkout'

#Item   Unit      Special
#       Price     Price
#--------------------------
#  A     50       3 for 130
#  B     30       2 for 45
#  C     20
#  D     15
RULES = {
  'A' => [[3,130], [1,50]],
  'B' => [[2,45],[1,30]],
  'C' => [[1,20]],
  'D' => [[1,15]],
}

class TestPrice < Test::Unit::TestCase

    def price(goods)
      co = Checkout.new(RULES)
      goods.split(//).each { |item| co.scan(item) }
      co.total
    end

    def test_totals
      assert_equal(  0, price(""))
      assert_equal( 50, price("A"))
      assert_equal( 80, price("AB"))
      assert_equal(115, price("CDBA"))

      assert_equal(100, price("AA"))
      assert_equal(130, price("AAA"))
      assert_equal(180, price("AAAA"))
      assert_equal(230, price("AAAAA"))
      assert_equal(260, price("AAAAAA"))

      assert_equal(160, price("AAAB"))
      assert_equal(175, price("AAABB"))
      assert_equal(190, price("AAABBD"))
      assert_equal(190, price("DABABA"))
    end

    def test_incremental
      co = Checkout.new(RULES)
      assert_equal(  0, co.total)
      co.scan("A");  assert_equal( 50, co.total)
      co.scan("B");  assert_equal( 80, co.total)
      co.scan("A");  assert_equal(130, co.total)
      co.scan("A");  assert_equal(160, co.total)
      co.scan("B");  assert_equal(175, co.total)
    end
  end
