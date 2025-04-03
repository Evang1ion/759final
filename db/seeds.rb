# 清空旧数据
OrderItem.delete_all
Order.delete_all
MenuItem.delete_all
Restaurant.delete_all
User.delete_all

# 创建测试用户
User.create!(
  name: "Alice Tester",
  email: "alice@example.com",
  password: "password",
  password_confirmation: "password"
)

puts "🧼 数据已清空，开始创建新餐厅和菜品..."

# 餐厅名字和菜品名数据
restaurant_names = [
  "Spicy Garden", "Ocean Delight", "Burger House", "Green Bowl",
  "Noodle Heaven", "Taco Time", "BBQ Station", "Sushi Zen",
  "Curry World", "Pasta Palace"
]

base_address = "Toronto"

dishes = [
  { name: "Spicy Chicken Wings", description: "Marinated in chili garlic sauce, served crispy with ranch dip." },
  { name: "Grilled Salmon", description: "Fresh Atlantic salmon grilled with lemon butter and herbs." },
  { name: "Classic Cheeseburger", description: "Beef patty, cheddar cheese, lettuce, tomato, secret sauce on brioche bun." },
  { name: "Caesar Salad", description: "Romaine, croutons, parmesan, Caesar dressing with optional grilled chicken." },
  { name: "Shrimp Tacos", description: "Three corn tacos with crispy shrimp, slaw, and spicy mayo." },
  { name: "BBQ Ribs", description: "Slow-cooked pork ribs glazed with smoky BBQ sauce." },
  { name: "Chicken Alfredo Pasta", description: "Creamy fettuccine alfredo topped with grilled chicken and parsley." },
  { name: "Sushi Combo", description: "Chef’s selection of 8 assorted sushi rolls and sashimi." },
  { name: "Beef Curry", description: "Tender beef in spicy Indian curry sauce with basmati rice." },
  { name: "Vegetable Stir Fry", description: "Seasonal vegetables stir-fried with garlic soy sauce over rice." }
]

# 创建 10 家餐厅
restaurant_names.each_with_index do |name, index|
  address = "#{1001 + index} King Street, #{base_address}"
  restaurant = Restaurant.create!(name: name, location: address)

  puts "🍴 创建餐厅：#{restaurant.name} (#{restaurant.location})"

  # 为每家餐厅创建 10 道菜
  dishes.each do |dish|
    restaurant.menu_items.create!(
      name: dish[:name],
      price: rand(8.0..18.0).round(2),
      description: dish[:description]
    )
  end
end

puts "✅ 共创建 #{Restaurant.count} 家餐厅，#{MenuItem.count} 道菜"
