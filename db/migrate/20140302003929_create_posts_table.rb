class CreatePostsTable < ActiveRecord::Migration
  def change
  	create_table :posts do |t|
		t.string :title
		t.text :content
		t.timestamps
		t.integer :user_id
	end
  end
end
