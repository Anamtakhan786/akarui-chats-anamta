class ConversationsController < ApplicationController
	before_action :set_conversation, except: [:index]
    before_action :check_participating!, except: [:index]
    
    def index
       #@users = User.where.not(id: current_user.id)
       # raise current_user.name.to_yaml
       @conversations = Conversation.participating(current_user).order('updated_at DESC')
    end
    def show
        #@users = User.where.not(id: current_user.id)
        @personal_message = PersonalMessage.new
    end
    private

    def set_conversation
  		@conversation = Conversation.find_by(id: params[:id])
	end

	def check_participating!
  		redirect_to authenticated_path unless @conversation && @conversation.participates?(current_user)
	end
end
