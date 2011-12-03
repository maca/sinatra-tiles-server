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
