class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      flash[:notice] = "Added friend."
      redirect_to root_url
    else
      flash[:error] = "Unable to add friend."
      redirect_to root_url
    end
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy
    # flash[:notice] = "Removed friendship."
    # redirect_to friendships_path
    render json: {msg:" friend removed"}
  end

    def index
         @friendships = current_user.friendships.where( :user_id => current_user.id)
    end


    def add_friend
      for user in User.all
        if params[:friend_email] == user.email && params[:friend_email] != current_user.email
           @friendship = current_user.friendships.build(:friend_id => user.id)
           respond_to do |format|
              if @friendship.save
                format.json { render json: { 'id': @friendship.id ,'img': @friendship.friend.image ,'name': @friendship.friend.username} }
              else
                format.json { render json: {'found': "already friend"}}

             end
           end
        end
    end
end
end
