App.order = App.cable.subscriptions.create "OrderChannel",
  connected: ->
    # Called when the subscription is ready for use on the ser
#    console.log " Hello Hala"

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
       
    # Called when there's incoming data con the websocket for this channel
    console.log(data['invitation'].order_id)
    console.log(data['invitation'])
    alert("You have an invitation!")
    $("#dropdowncontent").append(data['createdby'].username+' invited you to his '+'<\a href="/orders/'+data['order'].id+'">Order<\/a>'+'<button onclick="join(event)" id="'+data['invitation'].id+'">Join<\/button><br><br><br>')
