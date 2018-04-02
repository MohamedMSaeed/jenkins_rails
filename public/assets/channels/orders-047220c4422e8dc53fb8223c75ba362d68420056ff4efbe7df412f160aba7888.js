function finish_order(event){
    var id = $(event)[0].id
    $.ajax({
        type: "POST",
        url: "/orders/finish",
        data: {order_id:id , authenticity_token:$('meta[name="csrf-token"]').attr("content")},
        dataType: "json",
        success: function (response) {
            if(response['status']){
                $("#st"+response['order_id'])[0].innerHTML = "finished"
                $("#"+response['order_id']).parent().next('td').remove()
                $("#"+response['order_id'])[0].remove()
            }
        }
    });
}
;
