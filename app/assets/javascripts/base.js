function join(event) {
    id = $(event.target).attr('id')
    $.ajax({
        type: "POST",
        url: "/invited_to_orders/join",
        data: { invite_id: id, authenticity_token:$('meta[name="csrf-token"]').attr("content")},
        dataType: "json",
        success: function (response) {
            if(response['joined']){
                // $("#"+response['iid'][0].id).parent()[0].append('Order')
                $("#"+response['iid'][0].id).remove()
                console.log($("#"+response['iid'][0].id))
                console.log(response)
            }
        }
    });
}