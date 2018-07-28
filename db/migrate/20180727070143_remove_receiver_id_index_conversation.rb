class RemoveReceiverIdIndexConversation < ActiveRecord::Migration[5.2]
  def change
  	remove_index :conversations, :receiver_id
  end
end
