const dataset = [1, 2, 3, 4];
// const, let => var

d3.select('#prueba')
  // .attr('class', 'classprueba')
  .selectAll('p')
  .data(dataset)
  .enter()
  .append('p')
  .text(function(d) {
    return  'hola' + d;
  })