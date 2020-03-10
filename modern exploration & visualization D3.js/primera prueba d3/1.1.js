const data = [{x: 20, y:30, r:10}, {x:50, y: 70, r:20}];

d3.select('#prueba')
.append('svg')
.attr('width', 500)
.attr('height', 100)
.selectAll('circle')
.data(data)
.enter()
.append('circle')
.attr('cx', (d)=>{
	return d.x;
})
.attr('cy', (d)=> d.y)
.attr('r', function(d){
	return d.r;
})