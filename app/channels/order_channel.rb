class OrderChannel < ApplicationCable::Channel
def subscribed
      stream_from "order_#{current_user.id}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak
  end
end


