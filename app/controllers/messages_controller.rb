class MessagesController < ApplicationController
  before_action :set_message, only: %i[ show edit update destroy ]

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)

    if @message.save
      redirect_to contact_path, notice: "Thanks for the message! We will get back to you shortly."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def message_params
      params.require(:message).permit(:email, :content)
    end
end
