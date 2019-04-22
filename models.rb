class User < ActiveRecord::Base
	has_many :posts
	has_many :messages
	has_many :users_addresses
	has_many :addresses, through: :users_addresses
	has_one :profile
	has_and_belongs_to_many(:users,
													:join_table => "user_connections",
													:foreign_key => "user_a_id",
													:association_foreign_key => "user_b_id")
end

class Post < ActiveRecord::Base
	belongs_to :user
end

class Address < ActiveRecord::Base
	has_many :users_addresses
	has_many :users, through: :users_addresses
end
class Message < ActiveRecord::Base
	belongs_to :user
end

class UsersAddress < ActiveRecord::Base
	belongs_to :user
	belongs_to :address
end


class Profile < ActiveRecord::Base
    belongs_to :user
end
