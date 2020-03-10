const api = 'https://api.coindesk.com/v1/bpi/historical/close.json'

function parserData(data) {
    const bpi = data.bpi;
    const arr = [];
    for(let key in bpi) {
        arr.push({
            date: new Date(key),
            value: bpi[key],
        })
    }
    return arr;
}

// d3.csv(url)
d3.json(api)
.then((data)=>{
    const parser = parserData(data);
    drawChart(parser);
})
.catch((error)=>{
    console.log('error', error);
});

function drawChart(parser){
    const width = 600;
    const height = 400;
    const svg = d3.select('#prueba')
    .append('svg');

    svg.attr('width', width)
    .attr('height', height);

    const scaleY = d3.scaleLinear()
    .domain(d3.extent(parser, (d)=> d.value))
    .range([height, 0]);

    const scaleX = d3.scaleTime()
    .domain(d3.extent(parser, (d)=> d.date))
    .range([0, width]);

    const line = d3.line()
    .x(d=> scaleX(d.date))
    .y(d=> scaleY(d.value));

    const group = svg.append('g');
    const pathLine = group.append('path');

    pathLine
    .attr('fill', 'none')
    .attr('stroke', 'blue')
    .attr('stroke-width', 2)
    .attr('d', line(parser));

    const axisY = d3.axisLeft(scaleY).ticks(4);

    group.append('g')
    .attr('transform', 'translate(40, 0)')
    .call(axisY);

    const axisX = d3.axisBottom(scaleX).ticks(5);

    group.append('g')
    .attr('transform', `translate(0, ${height -20})`)
    .call(axisX);
}