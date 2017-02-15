class Orders < ActiveRecord::Base

belongs_to :users
belongs_to :items

end
