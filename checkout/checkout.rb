#RULES = {
#  'A' => [[3,130], [1,50]],
#  'B' => [[2,45],[1,30]],
#  'C' => [[1,20]],
#  'D' => [[1,15]],
#}

class Checkout
  attr_reader :rules_by_sku
  attr_accessor :count_by_sku

  def initialize(rules)
    @rules_by_sku = rules
    @count_by_sku = Hash.new { |h,k| h[k] = 0 }
  end

  def scan(sku)
    count_by_sku[sku] += 1
  end

  def find_rule(sku, count, rules)
    rules.find do |rule_count, price| 
      rule_count <= count
    end
  end

  def total
    result = 0
    count_by_sku.each do |sku, num_of_sku|
      rules_for_sku = rules_by_sku[sku]
      sku_count = num_of_sku

      while sku_count > 0
        rule = find_rule(sku, sku_count, rules_for_sku)

        if rule
          result += rule[1]
          sku_count -= rule[0]
        end
      end
    end

    result
  end
end
