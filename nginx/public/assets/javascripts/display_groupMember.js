function displayGpMember(event) {
    gId = $(event).attr("gid");
    $("#frindlist").empty();
    $("#frindlist").append(
        '<div id="group"><div>'
        +'<input type="text" id="membername" class="" gid="'+gId+'" style="width: 70%; background: white; border: black solid" >'
        +'<button id="add" onclick="addMember(this)" >Add</button>'
        +'</div></div><br><br>'
    )
    $.ajax({
        method:'GET',
        // url => groupmember#index
        url:'/group_members',

        // w bb3t el security m3 el id
        data: {
            id: gId, authenticity_token:$('meta[name="csrf-token"]').attr("content")
        },

        success: function(res){
            // append 3la div elly bt3rd el greoup member
            // console.log(res.group_members)
            // console.log(res.group_id)

            for (var i = 0; i < res.group_members.length; i++) {
                // $("#frindlist").append
                // ('<td><a href= "/users/' +res.group_members[i].id+ '">' +res.group_members[i].username+  '</a></td></ br><td><a  onclick=removeMember(this) class="delMember" mid='+res.group_members[i].id+' gid='+res.group_id+' >Remove</a></td>');
                $("#frindlist").append('<div class="col-lg-4 col-sm-6 portfolio-item">'
                    +'<img src=../../'+res.group_members[i].image.thumb.url+'/>'
                    +' '+res.group_members[i].username
                    +'<a onclick=removeMember(this) class="delMember" mid='+res.group_members[i].id+' gid='+res.group_id+' >Remove</a>'+'<br /><br /><br /></div>')
            }
        }
    })
}

function removeMember(event) {
    gId = $(event).attr("gid");
    mId = $(event).attr("mid");
    $.ajax({
        method:'POST',
        url:'/group_members/delete',
        data:{
            id : mId, g : gId, authenticity_token:$('meta[name="csrf-token"]').attr("content")
        },
        success:function (res) {
            if(res['deleted']){
                $(event).parent().remove()
            }
        }
    })
}

function addMember (event){
    member = $("#membername").val()
    gId = $("#membername").attr("gid");
    $.ajax({
        method:'POST',
        url:'/group_members/add',
        data: {
            memberName : member,group_id : gId, authenticity_token:$('meta[name="csrf-token"]').attr("content")
        },
        success:function (res) {
            $("#membername").val("")
            if(res['friend']) {
                $("#frindlist").append('<div class="col-lg-4 col-sm-6 portfolio-item">'
                    + '<img src=../../' + res['friend'].image.thumb.url + '/>'
                    + ' ' + res['friend'].username
                    + '<a onclick=removeMember(this) class="delMember" mid="' + res['friend'].id + '" gid="' + gId + '" >Remove</a>' + '<br /><br /><br /></div>')
            }
        }
    })
}


function addGroup (event){
    group = $("#add_group").val()
    $.ajax({
        method:'POST',
        url:'/groups/newGroup',
        data: {
            name: group , authenticity_token:$('meta[name="csrf-token"]').attr("content")
        },
        success:function (res) {
            console.log(res)
            $("#add_group").val(" ")
            $("#groupTable").append('<tr><td><p style="display:inline" onclick ="displayGpMember(this)" class="grpName" gid="'+res['group'].id+'">'+res['group'].name+'</p></td>'
            +'<td><a href="/groups/'+res['group'].id+'/edit'+'">Edit</a></td>'
            +'<td><a data-confirm="Are you sure?" class="gp-link" data-remote="true" rel="nofollow" data-method="delete" href="/groups/'+res['group'].id+'">'
            +'    <i class="fa fa-times-circle"></i></a></td></tr>'
            )
              $(".gp-link").bind('ajax:success', function () {
                $(this).parent().closest('tr').remove();
                })
        }
    })
}
$(".gp-link").bind('ajax:success',function(){$(this).parent().closest('tr').remove();})
