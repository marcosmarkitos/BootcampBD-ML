const data = [{x: 20, y: 30, r: 10}, {x: 50, y: 70, r: 20}];

const svg = d3.select('#prueba')
  .append('svg');

svg.attr('width', 500)
  .attr('height', 100);

const circle = svg
  .selectAll('circle')
  .data(data)
  .enter()
  .append('circle');

circle
  .attr('cx', (d) => {
    return d.x;
  })
  .attr('cy',(d) => d.y)
  .attr('r', function(d) {
    return d.r;
  })

// d3.select('#prueba')
//   .append('svg')
//   .attr('width', 500)
//   .attr('height', 100)
//   .selectAll('circle')
//   .data(data)
//   .enter()
//   .append('circle')
//   .attr('cx', (d) => {
//     return d.x;
//   })
//   .attr('cy', (d) => d.y)
//   .attr('r', function (d) {
//     return d.r;
//   })

  // function prueba() {
  //   this.hola = 'hola1';
  //   const h1 = () => {
  //     console.log('h1', this.hola);
  //   }
  //   const self = this;
  //   function h2() {
  //     console.log('h2', self.hola);
  //   }
  //   h1();
  //   h2();
  // }

  // prueba();