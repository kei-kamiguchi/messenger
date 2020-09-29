class MessagesController < ApplicationController
  before_action :set_conversation

  # コード改修案

  def index
    @messages = @conversation.messages.order(:created_at)
    @messages.where.not(user_id: current_user.id).update_all(read: true)
    unless @messages.length <= 10 || params[:show] == "all"
      @messages = @messages.last(10)
    end
    @message = Message.new
  end

  # テキスト通り

  # def index
  #   @messages = @conversation.messages
  #   if @messages.length > 10
  #     @over_ten = true
  #     @messages = Message.where(id: @messages[-10..-1].pluck(:id))
  #   end
  #   if params[:m]
  #     @over_ten = false
  #     @messages = @conversation.messages
  #   end
  #   if @messages.last
  #     @messages.where.not(user_id: current_user.id).update_all(read: true)
  #   end
  #   @messages = @messages.order(:created_at)
  #   @message = @conversation.messages.build
  # end

  def create
    @message = @conversation.messages.build(message_params)
    if @message.save
      redirect_to conversation_messages_path(@conversation)
    else
      render 'index'
    end
  end

  private
  def message_params
    params.require(:message).permit(:body, :user_id)
  end

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end
end
