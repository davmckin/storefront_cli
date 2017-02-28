class User < ActiveRecord::Base

has_many :orders, dependent: :restrict_with_error
has_many :addresses, dependent: :destroy
has_many :times, through: :orders

validates :first_name, presence: true
validates :last_name, presence: true
validates :email, presence: true#, format:

end
