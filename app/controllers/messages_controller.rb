class MessagesController < ApplicationController

  def show
    @message = Message.find(params[:id])
  end

  def new
    @message = Message.new
  end

  def create
    @message = PostMessageService.call(
      params[:message][:body],
      from: User.current,
      to: User.default_doctor
    )

    if @message.errors.count == 0
      redirect_to messages_url
    else
      render :new
    end
  end

end
