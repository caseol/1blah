# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $("#ranking_publicadores").dataTable
    bJQueryUI:true,
    oLanguage: { sUrl: "/assets/dataTables.portuguese.br.txt" },
    bAutoWidth: true,
    sWidth: "100%",
    aaSorting: []
  $("#ranking_tocadores").dataTable
    bJQueryUI: true,
    oLanguage: { sUrl: "/assets/dataTables.portuguese.br.txt" },
    bAutoWidth: true,
    aaSorting: []
  $("#ranking_media_toques").dataTable
    bJQueryUI:true,
    oLanguage: { sUrl: "/assets/dataTables.portuguese.br.txt" },
    bAutoWidth:true,
    aaSorting: []

