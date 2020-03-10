console.log('primark');

const map = L.map('map').setView([40.416992, -3.703526], 7);

L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
  attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
}).addTo(map);

d3.json('https://api.myjson.com/bins/1cc6a5')
  .then((primarks) => {
    console.log('primarks', primarks);
    printMap(primarks)
  });

function printMap(primarks) {
  const svg = d3.select(map.getPanes().overlayPane)
    .append('svg');

  svg.attr('width', 800)
    .attr('height', 400)
    .attr('class', 'svg-map');

  const group = svg
    .selectAll('.primarks')
    .data(primarks)
    .enter()
    .append('g');

  transformGroup(group)
  
  map.on('zoomstart', () => {
    group.attr('opacity', 0);
  })
  map.on('zoomend', () => {
    console.log('zoomend');
    transformGroup(group);
    group
      .transition()
      .duration(3000)
      .attr('opacity', 1);
  })
  const point = group.append('circle');
  point.attr('r', 5);
  const text = group.append('text');
  text.text((d) => {
    return d.Name;
  })
}

function transformGroup(group) {
  group
  .attr('transform', (d) => {
    const latLong = L.latLng(d.Latitude, d.Longitude);
    const point = map.latLngToLayerPoint(latLong);
    return `translate(${point.x}, ${point.y})`;
  })
}