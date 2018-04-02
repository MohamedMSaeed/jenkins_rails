function addFriendToList(){
    var friend = $("#add_friend").val()
    $.ajax({
        type: "POST",
        url: "/friendships/add_friend",
        data: { friend_email:friend, authenticity_token:$('meta[name="csrf-token"]').attr("content")},
        dataType: "json",
        success: function (response) {
            $("#add_friend").val("")
            if (response['found']){
                alert("Already Friend")
            }else {
                // console.log(response['img'].thumb.url)
                $("#friendlist").append('<div class="col-lg-4 col-sm-6 portfolio-item">'
                    + '<img src=' + response['img'].thumb.url + '/>'
                    + ' ' + response['name'] + ' '
                    + '<a data-confirm="Are you sure?" class="my-link" data-remote="true" rel="nofollow" data-method="delete" href="/friendships/' + response['id'] + '">Unfriend</a>'
                    // +'<a href="" class="my-link" onclick="RemoveFriend()" >Unfriend</a>'+'<br /><br /><br /></div>'
                )
                $(".my-link").bind('ajax:success', function () {
                    $(this).parent().remove();
                    console.log(response.msg)
                })
            }
        } 
    });

};

$(".my-link").bind('ajax:success',function(){$(this).parent().remove();})


  
    // alert(window.x)
        // $(event.target).parent().remove()

    // var r=confirm("Are you sure?")
    // // alert(event)
    // // console.log(event)
    // // console.log(event.target)
    // if (r == true ){
    //     // $(event.target).remove()
    //     // console.log(this)
        // $.ajax({
        //     type: "DELETE",
        //     url: "/friendships/destroy",
        //     data: { id: window.x , authenticity_token:$('meta[name="csrf-token"]').attr("content")},
        //     dataType: "json",
        //     success: function (response) {
        //         alert("done")
        //     }
        // });
    // }

