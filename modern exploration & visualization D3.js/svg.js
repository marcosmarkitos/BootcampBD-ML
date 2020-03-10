console.log('svg');

d3.select('#path34')
  .on('click', () => {
    d3.select('#path34')
      .transition()
      .duration(3000)
      .attr('transform', 'rotate(130)')
      .transition()
      .duration(3000)
      .attr('transform', 'translate(0, -500)')
  });