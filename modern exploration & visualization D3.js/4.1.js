const data = [
  [5, 20],
  [480, 90],
  [25, 50],
  [100, 33],
  [330, 95],
];

const ratio = 5;

const svg = d3.select('#prueba')
  .append('svg');

const size = 500;
svg.attr('width', size)
  .attr('height', size);

const xmax = d3.max(data, (d) => d[0]);
const xmin = d3.min(data, (d) => d[0]);
const scaleX = d3.scaleLinear()
  .domain([xmin, xmax])
  .range([ratio, size - ratio]);

const ymax = d3.max(data, (d) => d[1]);
const ymin = d3.min(data, (d) => d[1]);
const scaleY = d3.scaleLinear()
  .domain([ymin, ymax])
  .range([ratio, size - ratio]);

const group = svg.selectAll('g')
  .data(data)
  .enter()
  .append('g');

group.attr('transform', (d) => {
  const coordx = scaleX(d[0]);
  const coordy = scaleY(d[1]);
  return `translate(${coordx},${coordy})`;
});
const circle = group.append('circle');

circle
  .attr('cx', 0)
  .attr('cy', 0)
  .attr('r', ratio);

const text = group.append('text');

text.attr('x', (d) => {
  console.log(d);
  if (d[0] > (xmax / 2)) {
    return -50;
  }
  return 20;
})
  .attr('y',  (d)  =>  {
    if  (d[1] < (ymax  / 2)) {
      return 10;
    }
    return 0;
  })
  .text(d => {
    return  `[${d[0]}, ${d[1]}]`;
  });