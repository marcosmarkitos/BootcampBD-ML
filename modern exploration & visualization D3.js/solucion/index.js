//  Con windows.innerWidth cogemos el ancho del navegador
const windowWidth = window.innerWidth;
// Con window.innerHeight  cogemos el alto del navegador
const windowHeight = window.innerHeight;

d3.json('https://gist.githubusercontent.com/miguepiscy/2d431ec3bc101ef62ff8ddd0e476177f/raw/d9f3a11cfa08154c36623c1bf01537bb7b022491/practica.json')
.then((madrid) => {
  drawMap(madrid);
})

let feature;

function drawMap(featureCollection) {
  const width = windowWidth / 2;

  // Definimos los bordes
  const borderTop = 20;
  const borderLeft = 20;
  const borderBottom = 20;
  const borderRight = 20;
  
  // Cogemos  las features, en este caso como se trata de una colección únicamente
  // no necesitamos  la librería de topojson.
  const features = featureCollection.features;

  // Calculamos el  precio máximo
  const priceMax = d3.max(features, d => d.properties.avgprice);
  
  // Creamos nuestro svg
  const svg = d3.select('#map')
    .append('svg')
    .attr('width', width)
    .attr('height', windowHeight);
  
  
  // En esta proyección para usarla de forma genérica y no tener que buscar
  //  una  coordenada céntrica  en la  que centrar el mapa, voy a usar el centro de
  // la colección y para ello uso el método geoCentroid, podríamos pasar las coordenadas de
  // sol también como aprendimos en clase
  const center = d3.geoCentroid(featureCollection);

  // Con fitsize, le  pasamos el array con el ancho y el alto que  va a usar
  // y la colección y ajustará el tamaño a nuestro mapa, para poder calcularlo
  // automáticamente, podríamos dar un valor también con el .scale como vimos en clase
  const projection = d3.geoMercator()
    .fitSize([width - borderLeft - borderRight, windowHeight - borderTop - borderBottom], featureCollection)
    .center(center)
    .translate([(width / 2) + borderLeft, (windowHeight / 2) + borderTop]);

  // Con la proyección ya puedo generar mi path
  const path = d3.geoPath().projection(projection);


  // Creo un g donde irá el tooltip con la información al posicionarnos sobre un barrio
  const tooltip = svg.append('g')
    .attr('class', 'tooltip')
    .style('display', 'none')
    .attr('z-index', -1)


  // Por cada una de las feature  creo un path
  feature = svg.selectAll('.feature')
    .data(features)
    .enter()
    .append('path')
    .attr('class', 'feature');
  
  feature
    .attr('d', path)
    // Relleno el color   de mi path con la función fillColor
    .attr('fill', fillColor);

  feature
    .on("mouseover",  () => { tooltip.style("display", null); })
    .on("mouseout", () => { tooltip.style("display", "none"); })
    // Como necesitamos el this, en este caso no se podría usar una arrow function
    .on("mousemove", function (d) {
      // Cogemos la posición de nuestro ratón para posicionar el tooltip
      const xPosition = d3.mouse(this)[0] - 15;
      const yPosition = d3.mouse(this)[1] - 25;
      tooltip.attr('transform', `translate(${xPosition}, ${yPosition})`);

      // Seleccionamos el toooltip y actualizamos el texto
      const name = d.properties.name;
      const price = d.properties.avgprice || 0;
      const textElement = tooltip.select("text")
        .text(`${name}: ${price}€`);

      // Cogemos el ancho del texto para hacer un rect del mismo tamaño;
      const widthOfText = textElement.node().getComputedTextLength();
      tooltip.select('rect')
        .attr('x', - widthOfText / 2)
        .attr('width', widthOfText)
    })
  
  // Creo el rect del tooltip sin width (es decir width 0 por defecto)
  // por que lo cambiaré en función del texto
  tooltip.append('rect')
    .attr('height', 20)
    .attr('fill', 'white')
    .style('opacity', 0.5);

  tooltip.append('text')
    .attr('dy', '1.2em')
    .style('text-anchor', 'middle')
    .attr('font-size', '14px')
    .attr('font-weight', 'bold');

  // Como hemos definido tooltip antes que la feature, se queda debajo y no se vé
  // si tenemos algún elemento como este y  queremos cambiar el orden de pintado, podemos llamar a
  // raise y lo superpondrá al resto, podríamos solucionarlo también creando el tooltip debajo de
  // la feature
  d3.select('.tooltip').raise(); 

  // Voy a crear un g donde pondré mi leyenda
  const legend = svg.append('g');

  // Quiero usar  5 colores en mi leyenda, con 5 precios
  const numberOfLegends =  5;
  
  // Con esta  escala  lineal sacaremos cada uno de los puntos 
  // donde pondremos los colores, lo multiplicamos por 2, por que vamos a utilizar
  // rectángulos y en el eje X, tendremos que  tener en cuenta una coordenada x y un width
  const scaleLegend = d3.scaleLinear()
    .domain([0, numberOfLegends * 2])
    .range([0, width]);

  for (let index = 0; index < numberOfLegends * 2; index+=2) {
    //  Guardo  en posX  la coordenada "x" que la obtengo de la escala
    const posX = scaleLegend(index);

    // se resta 2 por que partimos de 0, las iteraciones irán de 2 a 8
    // en interpolateViridis introducimos un valor entre 0 y 1,
    // por lo que en cada iteración será 0,  0.25, 0.5, 0.75 y 1
    const percent = index / (numberOfLegends * 2 - 2);

    // como la iteración empieza en 0 y vamos  de dos en dos, tenemos que ir  de 0  al máximo menos  2
    const widthLegendUnit = (width / numberOfLegends) - 2;
    
    // Creo un  g para una unidad de leyenda en la que introduciremos el rect y el text
    // así  resultará  mas fácil posicionarlo
    const legendUnit = legend
      .append('g')
      .attr('transform', `translate(${posX}, 0)`);
    
    legendUnit
      .append('rect')
      .attr('width', widthLegendUnit)
      .attr('height', 15)
      .attr('fill', d3.interpolateViridis(percent))
    
    legendUnit
      .append('text')
      .text(`${priceMax * percent} €/m2`)
      // Es necesario usar function y  no arrow function, por que necesitamos el this
      .attr('transform', function(d) {
        const textLength = this.getComputedTextLength();
        const middle = widthLegendUnit / 2;
        return `translate(${middle - textLength / 2}, 30)`;
      });
  }

  function fillColor(d) {
    const price = d.properties.avgprice || 0;
    return d3.interpolateViridis(price / priceMax);
  }

  drawChartBedrooms(features[0].properties.avgbedrooms);
}

function drawChartBedrooms(avgbedrooms) {
  const marginLeft = 30;
  const marginTop = 30;
  const width = windowWidth / 2;
  const height = windowHeight - marginTop;

  const svg = d3.select('#chartBedrooms')
    .append('svg')
    .attr('width', width)
    .attr('height', height + marginTop);
  
  const scaleX = d3.scaleBand()
    // ya lo usamos en redraw para no repetir
    // .domain(avgbedrooms.map(d => d.bedrooms))
    .range([marginLeft, width])
    .padding(0.1);
  
  const scaleY = d3.scaleLinear()
    // ya lo usamos en redraw para no repetir
    // .domain([0, d3.max(avgbedrooms, d => d.total)]).nice()
    .range([height, marginTop])
  
  const color = d3.scaleOrdinal(d3.schemePaired);

  // Como más adelante hemos vuelto a utilizar una escala, he creado esta función para no repetir código
  const { xAxis, yAxis } = addAxis(svg, scaleX, scaleY, height, marginLeft);

  feature
    .on("click", d => redraw(d.properties.avgbedrooms));

  redraw(avgbedrooms);

  function redraw(avgbedrooms) {
    const speed = 300;

    scaleX.domain(avgbedrooms.map(d => d.bedrooms))
    scaleY.domain([0, d3.max(avgbedrooms, d => d.total)]).nice()

    svg.selectAll(".axisX").transition().duration(speed)
      .call(xAxis);
    svg.selectAll(".axisY").transition().duration(speed)
      .call(yAxis);

    svg.selectAll('.bar').remove();
    const group = svg
      .selectAll('.bar')
      .data(avgbedrooms)
      .enter()
      .append('g')
      .attr('class', 'bar');

    const rect = group
      .append('rect')

    rect
      .attr('x', d => scaleX(d.bedrooms))
      // se pone en height para que la animación vaya de abajo hacia arriba,
      // si lo eliminamos iría en el curso normal de pintado, que también estaría correcto,
      // pero para ver como podemos jugar con cambios en las transiciones solo con un estado inical
      .attr('y', height)
      .attr('width', scaleX.bandwidth())
      .attr('fill', d => color(d.bedrooms))

    rect
      .transition().duration(speed)
        .attr('y', d => scaleY(d.total))
        .attr('height', d => scaleY(0) - scaleY(d.total))

    const text = group
      .append("text")
      .text((d) => d.total)
      .attr('x', function(d) {
        const textLength = this.getComputedTextLength();
        return scaleX(d.bedrooms) + scaleX.bandwidth() / 2 - textLength / 2;
      })
      // se pone en height para que la animación vaya de abajo hacia arriba como la anterior
      .attr('y', height)
      .attr('fill', 'black');
      
    text
      .transition().duration(speed)
      .attr('y', (d) => {
        const borderTop = 15;
        const y = scaleY(d.total) + borderTop;
        return y > height ? height : y;
      })
  }

}

// Esta función reutiliza la lógica de la primera gráfica para crear
// los ejes de la segunda gráfica, 
function addAxis(svg, scaleX, scaleY, Xmax, Ymin) {
  const xAxis = (g) => g
    .attr("transform", `translate(0, ${Xmax})`)
    .call(d3.axisBottom(scaleX).tickSizeOuter(0));

  const yAxis = (g) => g
    .attr("transform", `translate(${Ymin}, 0)`)
    .call(d3.axisLeft(scaleY))

  svg.append("g")
    .attr('class', 'axisX')
    .call(xAxis);

  svg.append("g")
    .attr('class', 'axisY')
    .call(yAxis);

  return { xAxis, yAxis };

}

// Borrar valores outliers
function filterOutliers(values, property) {

  // Ordeno los valores
  values.sort((a, b) => {
    const data1 = a[property] || 0;
    const data2 = b[property] || 0;
    return data1 - data2;
  });
  
  const q1 = values[Math.floor((values.length / 4))][property];
  const q3 = values[Math.ceil((values.length * (3 / 4)))][property];
  const iqr = q3 - q1;

  const maxValue = q3 + iqr * 1.5;
  const minValue = q1 - iqr * 1.5;

  // Filtro los valores outliers
  const filteredValues = values.filter(function (x) {
    return (x[property] <= maxValue) && (x[property] >= minValue);
  });

  return filteredValues;
}