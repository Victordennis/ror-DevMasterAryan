def solution 
  puts "Please enter all the items purchased separated by a comma"
  items = gets.chomp
  items_list = items.split(",").map{|e| e.gsub(" ", "")}
  item_quality_hash = items_list.each_with_object(Hash.new(0)) { |item, hash| hash[item]+=1}
  calculate_item_price item_quality_hash 
end


def calculate_item_price item_quality_hash 
    sum, actual_price = 0 , 0  
    puts "Item     Quantity    Price"
    puts "........................."
    item_quality_hash.each do |key, value|
        actual_price = actual_price + value*static_price_hash[key]["unit_price"]
        item_static_detail = static_price_hash[key]
        sale_price = item_static_detail["sale_price"]
        if sale_price
            if sale_price["quantity"] > value
              sum = sum + item_static_detail["unit_price"]
              puts "#{key}    #{value}    $#{item_static_detail["unit_price"]}"
            else
              price = 0 
              unit_price_item = value%sale_price["quantity"]
              price = price + unit_price_item * item_static_detail["unit_price"] unless unit_price_item==0
              quantity_of_sale_price_item = value - unit_price_item 
              if quantity_of_sale_price_item > 0 
                  price = price + (quantity_of_sale_price_item/sale_price["quantity"])*sale_price["price"]
              end
              puts "#{key}      #{value}    $#{price}"
              sum = sum + price 
            end
        else
          sum = sum + item_static_detail["unit_price"]
          puts "#{key}      #{value}    $#{item_static_detail["unit_price"]}"
        end
    end
    puts ""
    puts "Total Price: $#{sum}"
    puts "You saved: $#{(actual_price - sum).round(2)} today."
end

def static_price_hash 
    {
        "milk"=> {"unit_price"=> 3.97, "sale_price"=> {"quantity"=> 2, "price"=> 5.00}},
        "bread"=> {"unit_price"=> 2.17, "sale_price"=> {"quantity"=> 3, "price"=> 6.00}},
        "banana"=> {"unit_price"=> 0.99},
        "apple"=> {"unit_price"=> 0.89}
    }
end

solution

