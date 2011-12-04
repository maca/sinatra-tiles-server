$(function() {
  // Hide the elements

  $("#config").hide();
  $("#new").hide();
  $("#share").hide();
  $("#action-1").hide();
  $("#action-2").hide();
  $("#action-3").hide();

  // Menu triggers
  $('.trigger').click(function() {
    $("#new").hide();
    $("#config").hide();
    $("#share").hide();
    $("#"+$(this).attr("rel")).fadeIn();
    if($(this).attr("rel")=='new')
      $("#action-1").fadeIn();

  });

  // Upload wizard
  $('.next-action').click(function() {
    var act = $(this).parent().attr("act");
    $("#action-"+act).hide();
    $("#action-"+(parseInt(act)+1)).fadeIn();

  });


  $( "#menu" ).draggable();


});


(function() {
  $(function() {
    var map, paint, po;
    paint = function(data) {};
    $.ajax({
      method: 'GET',
      url: '/json',
      success: function(data) {
        return paint(data);
      },
      dataType: 'json'
    });
    po = org.polymaps;
    map = po.map().container(document.getElementById("map").appendChild(po.svg("svg"))).center({
      lat: 25.67,
      lon: -100.30
    }).zoom(6).add(po.interact());
    return map.add(po.image().url(po.url("/tiles/{Z}/{X}/{Y}")));
  });
}).call(this);
