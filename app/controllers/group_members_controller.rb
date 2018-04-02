class GroupMembersController < ApplicationController
  before_action :authenticate_user!
  def destroy
# @group = Group.find(params[:group_id])
    
    @group_member = GroupMember.find(params[:id])
    @group_member.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Group member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def create
    @group = Group.find(params[:group_id])
    @group_member = @group.group_members.build(:user_id => params[:user_id],:group_id => params[:group_id] )

    if @group_member.save
      flash[:notice] = "Added friend."
      redirect_to root_url
    else
      flash[:error] = "Unable to add friend."
      redirect_to root_url

    end
  end

  def index

    @group_members = []
    @group_id = params[:id]
    @members_id = GroupMember.where(group_id: params[:id])
    @members_id.each do |member|
      friends = User.where(id: member.user_id)
      friends.each do |friend|
        @group_members.push(friend);
      end
    end
    render json: {group_members: @group_members,group_id: @group_id}



  end

  def delete

      @group_member = GroupMember.find_by(user_id: params[:id], group_id: params[:g])
      if @group_member.destroy
      respond_to do |format|
        format.json { render json: {deleted: "done"} }
        # format.json { head :no_content }
      end
    end
    
  end

  def add

    @addMember = User.find_by username: params[:memberName]
    @friends = current_user.friendships
    @found = 0
    if @addMember
      @friends.each do |friend|
        if @addMember.id == friend.friend_id
          @found = 1
          break
        end
      end
      if @found == 1
        respond_to do |format|
          puts(@addMember)
          @group = Group.find(params[:group_id])
          @group_member = @group.group_members.build(:user_id => @addMember.id,:group_id => params[:group_id] )
          if @group_member.save
            @friend = User.find_by id: @group_member.user_id
            format.json {render json: {group_member: @group_member, friend: @friend}}
          else
            flash[:error] = "Unable to add friend."
            # redirect_to root_url
            puts("ssssssssssssssssssssssssssssssssssssssssssssssssss")
          end
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



end
