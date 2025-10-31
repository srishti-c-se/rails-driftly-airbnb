class NotificationsController < ApplicationController
  def index
    @notifications = Notification.all
  end

  def read
    @notification = Notification.find(params[:id])
  end
end
