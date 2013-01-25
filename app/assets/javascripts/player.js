/**
 * Created by JetBrains RubyMine.
 * User: caseol
 * Date: 31/03/12
 * Time: 03:34
 * To change this template use File | Settings | File Templates.
 */
  //<![CDATA[
  $(document).ready(function(){
    $("#jquery_jplayer_1").jPlayer({
        ready: function () {
        },
        swfPath: "/swf",
        supplied: "mp3",
        wmode: "window"
    });
    $("#jquery_jplayer_1").bind($.jPlayer.event.ended, function(event){
      $(".jp-button").removeClass("jp-stop-new");
      $(".jp-button").addClass("jp-play-new");
    });

    $(".jp-button").click(function() {
        if($(this).hasClass('jp-play-new')){
          var v = $(this).attr("href");
          var btnId = $(this).attr("button-id");
          $("#jquery_jplayer_1").jPlayer("setMedia", {mp3: v}).jPlayer("play");

          $(this).removeClass("jp-play-new");
          $(this).addClass("jp-stop-new");
          button_play_count(btnId);
        }
        else{
          $(this).removeClass("jp-stop-new");
          $(this).addClass("jp-play-new");
          $("#jquery_jplayer_1").jPlayer("stop");
        }
        return false;
    });

    //if($(".jp-audio").attr("user-id")!= ""){
        $(".jp-audio").mouseover(function(event){
            var btnId = $(this).attr("button-id");
           $("#title_"+ btnId).hide();
           $("#function_"+ btnId).show();
        });
        $(".jp-audio").mouseout(function(event){
            if(!$(event.relatedTarget).hasClass("jp-function")){
                var btnId = $(this).attr("button-id");
                $("#title_"+ btnId).show();
                $("#function_"+ btnId).hide();
            }
        });
        $(".jp-function").mouseout(function(event){
            if(!$(event.relatedTarget).hasClass("jp-function")){
                var btnId = $(this).attr("button-id");
                $("#title_"+ btnId).show();
                $("#function_"+ btnId).hide();
            }
        });
    //}
  });
//]]>
