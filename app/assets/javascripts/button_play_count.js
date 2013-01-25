/**
 * Created by JetBrains RubyMine.
 * User: caseol
 * Date: 03/04/12
 * Time: 20:08
 * To change this template use File | Settings | File Templates.
 */
$(document).ready(function(){
    $(".jp-function-favorite").click(function() {
        var v = $(this).attr("href");
        var btnId = $(this).attr("button-id");
        manageFavorite(btnId);
        return false;
    });
});

function manageFavorite(btnId){

    var option ={
      type: "GET",
      url: "/manage_favorite/?button_id="+btnId,
      dataType: "json",
      complete: handleManageFavorite
    }
    $.ajax(option);
}

function handleManageFavorite(XHR, statusText){
    var result = eval("("+XHR.responseText+")");
    state = $("#favorite_link_"+result.id).attr("favorite-state");
    if (state == "0"){
        $("#favorite_link_"+result.id).attr("favorite-state", 1);
        $("#favorite_link_"+result.id).text("Remover dos Favoritos");
    }
    else{
        $("#favorite_link_"+result.id).attr("favorite-state", 0);
        $("#favorite_link_"+result.id).text("Adicionar aos Favoritos");
    }
}

var idTimerButtonPlay = 0;
function button_play_count(btnId){
    var option ={
      type: "GET",
      url: "/count_play/?button_id="+btnId,
      dataType: "json",
      complete: handleCountPlay
    }
    if (idTimerButtonPlay != 0) {clearTimeout (idTimerButtonPlay)};
    idTimerButtonPlay = setTimeout(function(){
        $.ajax(option);
    }, 800);
}

function handleCountPlay(XHR, statusText){
    var result = eval("("+XHR.responseText+")");
    $("#total_plays_"+result.button_id).html(result.value);
    //$("#private_visit_count_info").html(result.visit.item.count);
}