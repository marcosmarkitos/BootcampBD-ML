const input = [5, 10, 15, 20];
const maxInput = d3.max(input);

const svg = d3.select('#prueba')
  .append('svg');

const height = 200;
svg
  .attr('width', 500)
  .attr('height', height);

const rect = svg
  .selectAll('rect')
  .data(input)
  .enter()
  .append('rect');

rect.attr('class', (d) => {
  if (d > 10) {
    return 'rectwarning';
  }
})

const rectWidth = 20;
rect
  .attr('x',  posX)
  .attr('y', posY)
  .attr('width', rectWidth)
  .attr('height', scale);
  // .attr('height', (d) =>  scale(d));

const text = svg.selectAll('text')
  .data(input)
  .enter()
  .append('text');

text.text(d => d)
  .attr('x', posX)
  .attr('y', (d) => posY(d) - 3);

text.attr('class', (d) => {
  if (d > 10) {
    return 'text rectwarning';
  }
  return 'text';
})
function scale(d) {
  const scaleNum = (height - 20) / maxInput;
  return scaleNum * d;
}

function posX(d, index) {
  return index * (rectWidth + 1);
}

function posY(d) {
  return height - scale(d);
}

