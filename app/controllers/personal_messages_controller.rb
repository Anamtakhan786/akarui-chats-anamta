class PersonalMessagesController < ApplicationController
   before_action :find_conversation!

	 	def create
        if params[:conversation_id]
              @conversation = Conversation.find(params[:conversation_id])
              conversation_mail(params)
        end
        if params[:receiver_id]
              @conversation = Conversation.new(author_id: current_user.id,
                                          receiver_id: @receiver.id)
           if @conversation.save
              conversation_mail(params)
              @user = User.find(params[:receiver_id])
              UserNotifierMailer.notify_email(@user).deliver
           end
        end
		end

    def conversation_mail(params)
      @personal_message = current_user.personal_messages.build(personal_message_params)
      @personal_message.conversation_id = @conversation.id
      @personal_message.save!
      flash[:success] = "Your message was sent!"
      redirect_to conversation_path(@conversation)
    end
  	def new
        @users= User.all.where.not(id: current_user.id)
  			redirect_to conversation_path(@conversation) and return if @conversation
  			@personal_message = current_user.personal_messages.build
		end
    def index
      @users = User.all.where.not(id: current_user.id)
    end
  private

  	def personal_message_params
    	params.require(:personal_message).permit(:body)
  	end

  	def find_conversation!
  		if params[:receiver_id]
    		@receiver = User.find_by(id: params[:receiver_id])
    		redirect_to(root_path) and return unless @receiver
    		@conversation = Conversation.between(current_user.id, @receiver.id)[0]
  		else
    		@conversation = Conversation.find_by(id: params[:conversation_id])
    		redirect_to(root_path) and return unless @conversation && @conversation.participates?(current_user)
  		end
	end
end
