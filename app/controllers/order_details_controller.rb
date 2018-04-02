class OrderDetailsController < ApplicationController
  before_action :authenticate_user!
  def destroy
 @order_detail = OrderDetail.find(params[:id])
    if @order_detail.destroy
    flash[:notice] = "deleted your order."
      
    else
      flash[:error] = "Unable to delete order."
    end
render json: {msg:"msg"}
  end

  def create
    @invited = InvitedToOrder.find_by order_id: params[:order_id], user_id: params[:user_id]
    @order = Order.find(params[:order_id])
    # if @order.user_id == current_user.id
    #   @order_detail = @order.order_details.build(:order_id => params[:order_id],:user_id => params[:user_id],:item => params[:item],:amount => params[:amount],:price => params[:price],:comment => params[:comment] )
    #   if @order_detail.save
    #     flash[:notice] = "Added your order."
    #   else
    #     flash[:error] = "Unable to add order."
    #   end
    #   render json: @order_detail
    # end
    # if @invited
      if (@invited && @invited.status == "joined") ||  @order.user_id == current_user.id
          @order_detail = @order.order_details.build(:order_id => params[:order_id],:user_id => params[:user_id],:item => params[:item],:amount => params[:amount],:price => params[:price],:comment => params[:comment] )
          if @order_detail.save
            flash[:notice] = "Added your order."
          else
            flash[:error] = "Unable to add order."
          end
          render json: @order_detail
      end
    # end

  end

  def index

    @group_members = []
    @members_id = GroupMember.where(group_id: params[:id])
    @members_id.each do |member|
      friends = User.where(id: member.user_id)
      friends.each do |friend|
        @group_members.push(friend);
      end
    end
    
    print(@group_members)
    render json: @group_members

  end

    end
