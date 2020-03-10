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

const circle = svg.selectAll('circle')
  .data(data)
  .enter()
  .append('circle');

circle
  .attr('cx', (d) => scaleX(d[0]))
  .attr('cy', (d) => scaleY(d[1]))
  .attr('r', ratio);