d3.json('https://gist.githubusercontent.com/miguepiscy/2d431ec3bc101ef62ff8ddd0e476177f/raw/2482274db871e60195b7196c602700226bdd3a44/practica.json')
.then((featureCollection) => {
    drawMap(featureCollection);
    
});

function drawMap(featureCollection) {
    
    const width = 600;
    const height = 500;

    const svgLeft = d3.select('#madrid')
    .append('svg');

    svgLeft.attr('width', width)
    .attr('height', height)
    
    const center = d3.geoCentroid(featureCollection);
    const projection = d3.geoMercator()
    .fitSize([width, height], featureCollection)
    .center(center)
    .translate([width/2, height/1.85])

    const pathProjection = d3.geoPath().projection(projection);

    const features = featureCollection.features;

    const groupMap = svgLeft.append('g').attr('class', 'map');
     
    const subunitsPath = groupMap.selectAll('.subunitsPath')
    .data(features)
    .enter()
    .append('path');

    subunitsPath.attr('d', pathProjection);

    subunitsPath.on('click', function clickSubunit(d) {
        d3.select(this);
        drawGraph(d.properties.avgbedrooms,d.properties.name);
    })

    const rangeAvgPrice = d3.extent(features, (d)=> d.properties.avgprice);
    //console.log('rango', rangeAvgPrice);

    const color = d3.scaleLinear()
    //.domain([15,151])
    .domain(rangeAvgPrice)
    .range(["green","red"]);

    subunitsPath.attr('fill', (d) => color(d.properties.avgprice));

    

    const legend = d3.legendColor()
    .scale(color)
    .title('Avg Price (€)');

    const groupLegend = svgLeft.append('g')
    .attr('class', 'legendGraph')
    .attr('transform', 'translate(500,15)')
    .call(legend);

}

function drawGraph (propertiesToDraw, name){
    
    const width = 600;
    const height = 500;
    const margin = 100;
    const barWidth = 50;

    const svgRight = d3.select('#detail')
    .append('svg');

    svgRight.attr('width', width)
    .attr('height', height);

    const title = svgRight.append('text');

    title.attr('class', 'title')
    .attr('x', margin)
    .attr('y', margin/2)
    .text(`Barrio: ${name}`);

    const reformatedProperties = propertiesToDraw.map(function(obj){
        const rObj = [obj.bedrooms, obj.total];
        return rObj;
    })

    //const rangeX = [d3.min(reformatedProperties, (d)=>d[0]), reformatedProperties.length];
    const rangeX = d3.extent(reformatedProperties, (d)=>d[0]);
    const rangeY = d3.extent(reformatedProperties, (d)=>d[1]);
    
    console.log('eje x', rangeX);
    console.log('eje y', rangeY);

    const scaleX = d3.scaleLinear()
    .domain(rangeX)
    .range([margin, width-(margin/2)]);

    const scaleY = d3.scaleLinear()
    .domain(rangeY)
    .range([height-margin, margin]);

    console.log('dominio Y', rangeY);
    console.log('rango Y', [height-margin, margin]);

    const groupGraph = svgRight.selectAll('g')
    .data(reformatedProperties)
    .enter()
    .append('g');
    
    groupGraph.attr('transform', (d) => {
        const coordX = scaleX(d[0]);
        const coordY = scaleY(d[1]);
        return `translate(${coordX}, ${coordY})`;
    });

    const bar = groupGraph.append('rect');

    bar
    .attr('class', 'bar')
    .attr('x', 0-(barWidth/2))
    .attr('y', 0)
    .attr('width', barWidth)
    .attr('height', (d)=>d[1]);

    const tag = groupGraph.append('text');

    tag.attr('x', -5)
    .attr('y', -2)
    .text(d=> `${d[1]}`);

    //const xAxis = d3.axisBottom(scaleX).ticks(reformatedProperties.length);
    const xAxis = d3.axisBottom(scaleX).ticks(2);

    const groupAxisX = svgRight.append('g');

    groupAxisX
    .attr('transform', `translate(0, ${height - margin})`)
    .call(xAxis);

    const Xlabel = groupAxisX.append('text');

    Xlabel.attr('x', width/2)
    .attr('y', 0)
    .text('Número de habitaciones');
    
    

    const yAxis = d3.axisLeft(scaleY);

    const groupAxisY = svgRight.append('g');

    groupAxisY
    .attr('transform', `translate(${3*margin/4 }, 0)`)
    .call(yAxis);

    const Ylabel = groupAxisY.append('text');

    Ylabel.attr('x', 0)
    .attr('y', 0)
    .attr('transform', 'rotate(-90)')
    .text('Número de propiedades');


    function posX(d, index) {
        return index * (barWidth + 1);
    }
    
}

