require 'minitest/autorun'

require_relative 'models/item'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => 'db/store.sqlite3'
  )

class ItemTest < MiniTest::Test

    def test_five
      assert Item.five.count == 5
    end

    def test_price_is_required
      item = Item.new(category: "sure", title: "su")
      refute item.save
      assert 
    end

end
