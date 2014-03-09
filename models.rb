class User < ActiveRecord::Base
	has_many :posts
	has_many :users_addresses
	has_many :addresses, through: :users_addresses
end

class Post < ActiveRecord::Base
	belongs_to :user
end

class Address < ActiveRecord::Base
	has_many :users_addresses
	has_many :users, through: :users_addresses
end

class UsersAddress < ActiveRecord::Base
	belongs_to :user
	belongs_to :address
end
