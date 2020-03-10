const dataInput = [
    {platform : 'Android', color: 'green', percentage: 80},
    {platform : 'Ios', color: 'grey', percentage: 19},
    {platform : 'Windows', color: 'blue', percentage: 1},
];

const width = 500;
const height = 500;
const ratio = d3.min([width, height])/2;

const svg = d3.select('#prueba')
.append('svg');

svg.attr('width', width)
.attr('height', height);

const arc = d3.arc()
.innerRadius(ratio/1.5)
.outerRadius(ratio);

//const percentages = data.map(d=>d.percentage);
//d3.pie()(percentages);
const pie = d3.pie().value(d=>d.percentage);
const dataPie = pie(dataInput);

const group = svg.selectAll('g')
.data(dataPie)
.enter()
.append('g');

group.attr('transform', `translate(${ratio},${ratio})`);

const pathPie = group.append('path');

pathPie.attr('d', arc);

const scaleColor = d3.scaleOrdinal(d3.schemeCategory10)

pathPie.attr('fill', (d, i)=>{
    return scaleColor(i);
});

group.append('text')
.attr('transform',(d) => {
    const center = arc.centroid(d);
    return `translate(${center[0]},${center[1]})`
})
.text(d=>d.data.platform)