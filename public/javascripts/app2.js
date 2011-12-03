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

function load(e) {
  console.log(e);
  // var cluster = e.tile.cluster || (e.tile.cluster = kmeans()
  //     .iterations(16)
  //     .size(64));

  // for (var i = 0; i < e.features.length; i++) {
  //   cluster.add(e.features[i].data.geometry.coordinates);
  // }

  // var tile = e.tile, g = tile.element;
  // while (g.lastChild) g.removeChild(g.lastChild);

  // var means = cluster.means();
  // means.sort(function(a, b) { return b.size - a.size; });
  // for (var i = 0; i < means.length; i++) {
  //   var mean = means[i], point = g.appendChild(po.svg("circle"));
  //   point.setAttribute("cx", mean.x);
  //   point.setAttribute("cy", mean.y);
  //   point.setAttribute("r", Math.pow(2, tile.zoom - 11) * Math.sqrt(mean.size));
  // }
}
