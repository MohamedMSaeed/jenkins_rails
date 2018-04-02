class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.where(user_id: current_user.id).order("created_at DESC")
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @user = current_user
    @order_detail = OrderDetail.new
  end

  # GET /orders/new
  def new
    @order = Order.new
    @user = current_user
    @friends = []
    @user.friendships.each {|friend|
      @friends << friend.friend_id
      }
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @user = User.find_by(id: current_user.id)
    @order.user_id = current_user.id
    friendsList = @@friendsList
    puts(friendsList)
    respond_to do |format|
      if @order.save
        if friendsList
        friendsList.each do |f|
          @invited = InvitedToOrder.new(order_id: @order.id, user_id: f, status: "invited" )
          @invited.save
          ActionCable.server.broadcast "order_#{f}_channel" , {order:@order, createdby:@user, invitation:@invited}

        end
        end

        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def putList
    @@friendsList = params[:friends]
  end

  def finish
    @finishedOrder = Order.find_by(id: params[:order_id])
    respond_to do |format|
      if @finishedOrder.update(status: "finished")
        format.json { render json: {'status':@finishedOrder.status , 'order_id':@finishedOrder.id}}
      else
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:meal, :resturant, :image, :status, :user_id)
    end
end
