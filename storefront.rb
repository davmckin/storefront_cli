require 'rubygems'
require 'bundler/setup'
require 'tty'
require 'active_record'
require 'sqlite3'
require 'pry'
require_relative 'models/address'
require_relative 'models/item'
require_relative 'models/order'
require_relative 'models/user'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => 'db/store.sqlite3'
)
puts User.count

Item.order(price: :desc).limit(5).each do |o|
  puts "#{o.title} costs #{o.price}"
end

Item.order(price: :asc).where(category: "Books").limit(1).each do |o|
  puts "Cheapest book is #{o.title}"
end

Address.where(street: "6439 Zetta Hills").limit(1).each do |o|
User.where(id: o[:user_id]).limit(1).each do |n|
  puts "#{n.first_name} #{n.last_name} lives there."
end
end
#or you can do it the MUCH SIMPLER WAY
# Address.where(street: "6439 Zetta Hills").limit(1).each do |i|
  #puts i.user.first_name
#end

Address.where(user_id: 40).limit(2).each do |a|
  puts a.street
end

user_v_m = User.where(first_name: "Virginie",last_name: "Mitchell").first
user_v_m.addresses.update(city: "New York", state: "NY", zip: 10108)

prices = []
Item.where("category LIKE '%tools%'").each do |a|
  prices << a.price
end
puts prices.inject(:+)

how_many = []
Order.all.each do |o|
  how_many << o.quantity
end
puts how_many.inject(:+)

most_ordered = Item.joins(:orders)
                    .order("sum_order_quantity desc")
                    .groups(:title)
                    .sum("orders.quantity").first
puts most_ordered

#how much was spent on books

books_total = Item.joins(:orders)
                        .where("category LIKE '%books%'")
                        .sum("price*quantity")
puts "$#{books_total} was spent on books."
