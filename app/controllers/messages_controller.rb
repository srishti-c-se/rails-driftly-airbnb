class MessagesController < ApplicationController
  def create
    @booking = Booking.find(params[:booking_id])
    @message = Message.new(message_params)
    @message.threadable = @booking
    @message.user = current_user
    if @message.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(:messages, partial: "messages/message",
            locals: { message: @message })
        end
        format.html { render "bookings/show", status: :see_other }
      end
    else
      render "bookings/show", status: :unprocessable_entity
    end
  end

  def update
    
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end
