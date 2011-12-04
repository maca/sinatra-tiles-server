var po = org.polymaps;

var map = po.map()
    .container(document.getElementById("map").appendChild(po.svg("svg")))
    .center({lat: 25.67, lon: -100.30})
    .zoom(6)
    .zoomRange([5, 8])
    .add(po.interact());

map.add(po.image()
    .url(po.url("/tiles/{Z}/{X}/{Y}.png")
    ));

map.add(po.geoJson()
    .url("/json?bbox={B}")
    .on("load", load)
    .clip(false)
    .zoom(6));

map.add(po.compass()
    .pan("none"));

var setRadius = function(attribute) {
  $('svg.map circle.point').each(function(){
  
  });
  // var r = 1200 * Math.pow(2, e.tile.zoom - 12);
  // point.setAttribute("r", r);
}

function load(e) {
  for (var i = 0; i < e.features.length; i++) {
    var f = e.features[i],
    c = f.element;
    g = f.element = po.svg("g");

    point = g.appendChild(po.svg("circle"));
    point.setAttribute("cx", 0);
    point.setAttribute("cy", 0);
    point.setAttribute("class", "point")
    point.setAttribute("r", 10);

    g.setAttribute("transform", c.getAttribute("transform"));
    g.setAttribute("style","cursor:pointer;");
    g.setAttribute("data-name", f.data.id);
    c.parentNode.replaceChild(g, c);
  }
}
