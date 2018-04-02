class StartController < ApplicationController

  def start
    render :layout => false
    # @user = current_user
    # @group = @user.groups.build
    # @groups = @user.groups
  end
end
