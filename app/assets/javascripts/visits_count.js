/**
 * Created by JetBrains RubyMine.
 * User: caseol
 * Date: 02/04/12
 * Time: 00:06
 * To change this template use File | Settings | File Templates.
 */
$(document).ready(function(){
    count();
});

function count(){
    var option ={
          type: "GET",
          url: "/count_visit",
          dataType: "json",
          complete: handleCount
    }
    $.ajax(option);
}

function handleCount(XHR, statusText){
    var result = eval("("+XHR.responseText+")");
    $("#visit_count_info").html(result.visit.total);
    $("#private_visit_count_info").html(result.visit.item.count);
    $("#play_count_info").html(result.visit.total_play);
}