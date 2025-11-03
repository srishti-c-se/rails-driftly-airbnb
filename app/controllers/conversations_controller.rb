class ConversationsController < ApplicationController
  before_action :authenticate_user!
  def index
    @conversations = current_user.conversations_as_sender
  end

  def show
    @conversation = Conversation.find(params[:id])
    @messages = @conversation.messages.order(created_at: :asc)
  end

  def new
    @conversation = Conversation.new
  end

  def create
    @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).where(vehicle_id: params[:vehicle_id]).first_or_initialize(conversation_params)
    if @conversation.save
      redirect_to conversation_messages_path(@conversation)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end
end
