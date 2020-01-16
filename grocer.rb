def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  item_index = 0
  return_value = nil
  while (collection[item_index]) do
    if(collection[item_index][:item] == name)
      return_value = collection[item_index]
    end
    item_index+=1
  end
  return_value
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  
  return_array = []
  for i in cart do
      item_index = 0
      found = false
      while(return_array[item_index]) do
        if(return_array[item_index][:item] == i[:item]) 
          found = true
          break
        end
        item_index+=1
      end
      if(found == true)
        return_array[item_index][:count]+=1
      else
        item_to_hash = {:item => i[:item], :price => i[:price], :clearance => i[:clearance], :count => 1}
        return_array.push(item_to_hash)
      end
  end
  return_array
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  coupons_applied_cart = []
  
  
  for i in coupons do
    
    coupon_item_name = i[:item]
    cart_index = 0
    item_found = false
    found_cart_item = {}
    while(cart[cart_index]) do
      if(cart[cart_index][:item] == coupon_item_name)
        item_found = true
        found_cart_item = {:item => cart[cart_index][:item], :price => cart[cart_index][:price], :clearance => cart[cart_index][:clearance], :count => cart[cart_index][:count]}
        cart[cart_index][:count]-= i[:num]
        break
      end
      cart_index+=1
    
    end
    
    if(item_found)
      cart.push(found_cart_item)
      cart.last()[:item] = cart.last()[:item] + " W/COUPON"
      cart.last()[:price] = i[:cost] / i[:num]
      cart.last()[:count] = i[:num]
    end
  end

  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  #value = {(i[:price] * 0.20).round(2)
  #puts "BEGIN OF apply_clearance"
  #puts cart
  
  for i in cart do
    if(i[:clearance] == true)
      i[:price] = (i[:price] - (i[:price] * 0.20).round(2))
    end
  end
  
  #puts "END OF apply_clearance"
  #pp cart
  cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  
  consolidated_cart = consolidate_cart(cart)
  consolidated_cart = apply_coupons(consolidated_cart, coupons)
  consolidated_cart = apply_clearance(consolidated_cart)
  
  puts "CONSOLIDATED CART BEFORE TOTAL"
  puts consolidated_cart
  
  total = 0.0
  for i in consolidated_cart do
  
    total = total + i[:price] * i[:count]
  end
  
  if (total > 100.00)
    total = total - (total * 0.10.round(2))
  end
  total
end
