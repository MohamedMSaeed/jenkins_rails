class InvitedToOrdersController < ApplicationController
  before_action :authenticate_user!
  def invite
    @friends = current_user.friendships
    @inputfriend = User.find_by username: params[:friendName]
    @found = 0
    if @inputfriend
      @friends.each do |friend|
        if @inputfriend.id == friend.friend_id
          @found = 1
          break
        end
      end
      if @found == 1
        respond_to do |format|
            puts(@inputfriend)
            format.json { render json: {'friend':@inputfriend} }
        end
      else
        respond_to do |format|
          format.json { render json: {'NotFriend':"not found"} }
        end
      end
    else
      respond_to do |format|
        format.json { render json: {'Alert':"not found"} }
      end
    end
  end
def showInvited
        @invited_to_order=InvitedToOrder.where(order_id: params[:order_id])
        @invited_to_orders= []
        @invited_to_order.each do |inv|
        if inv.status == 'invited'
        friend = User.where(id: inv.user_id)
        @invited_to_orders.push(friend)

      end
end

    render json: {friends: @invited_to_orders}
end
def showJoined
        @invited_to_order=InvitedToOrder.where(order_id: params[:order_id])
        @friends= []
        @invited_to_order.each do |inv|
        if inv.status == 'joined'
        friend = User.where(id: inv.user_id)
        @friends.push(friend);
      end
end
    render json: {friends: @friends}
end
  def inviteGroup
    @groups = current_user.groups
    @inputgroup = Group.find_by name: params[:groupName]
    # @inputgroup = Group.where(name: params[:groupName], user_id: current_user.id)

    @found = 0
    if @inputgroup
      @groups.each do |group|
        if @inputgroup.id == group.id
          @found = 1
          break
        end
      end
      if @found == 1
        @members = GroupMember.where(group_id: @inputgroup.id)
        @invitedList = []
        @members.each do |member|
          invited = User.find_by id: member.user_id
          @invitedList << invited.username
        end
        # hna hageb el users then usernames then add them to invited :D
        respond_to do |format|
          format.json { render json: {'group':@inputgroup, 'group_members':@invitedList} }
        end
      end
    else
      respond_to do |format|
        format.json { render json: {'Alert':"not found"} }
      end
    end
  end

  def join
    @invitation = InvitedToOrder.where(id: params[:invite_id])
    if @invitation.update(status: 'joined')
      p @invitation
      respond_to do |format|
        format.json { render json: {'joined':"done", 'iid':@invitation} }
      end
    end
  end
end
