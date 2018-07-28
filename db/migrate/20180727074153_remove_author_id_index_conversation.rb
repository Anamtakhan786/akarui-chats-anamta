class RemoveAuthorIdIndexConversation < ActiveRecord::Migration[5.2]
  def change
  	remove_index :conversations, :author_id
  end
end
