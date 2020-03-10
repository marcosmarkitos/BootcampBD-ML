const dataset = [1, 2, 3, 4];
//const, let => var
//const no permite modificar la varible, let sí

d3.select('#prueba')
//.attr('class', 'classprueba')
.selectAll('.texto')
.data(dataset)
.enter()
.append('p')
.text(function(d){
	return 'hola' + d;
})