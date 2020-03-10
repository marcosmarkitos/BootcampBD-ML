const dataInput = [5, 10, 15, 20];

const svg = d3.select('#prueba')
  .append('svg');

svg.attr('width', 500)
  .attr('height',100);

const circle = svg
  .selectAll('circle')
  .data(dataInput)
  .enter()
  .append('circle');
const max = d3.max(dataInput);
console.log('max', max);
let total = 0;
circle
  .attr('cx', (data, index) => {
    console.log(index);
    total = total + data * 2;
    return total;
  })
  .attr('cy', max)
  .attr('r', (d) => d);