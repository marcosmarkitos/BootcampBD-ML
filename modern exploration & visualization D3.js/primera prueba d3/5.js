const data = [
    [5, 20, 20],
    [480, 90, 30],
    [25, 50, 20],
    [100, 33, 20],
    [330, 95, 30],    
];

const width = 500;
const height = 500;
const ratioMax = d3.max(data, d => d[2]);
const sizeAxisX = 20;

//d3.extent => [min, max]
const scaleX = d3.scaleLinear()
.domain(d3.extent(data, d => d[0]))
.range([ratioMax, width - ratioMax]);

const scaleY = d3.scaleLinear()
.domain(d3.extent(data, d => d[1]))
.range([height - ratioMax - sizeAxisX, ratioMax]);

console.log('dominio Y', d3.extent(data, d => d[0]));
console.log('rango Y', [ratioMax, width - ratioMax]);

const svg = d3.select('#prueba')
.append('svg');

svg.attr('width', width)
.attr('height', height);

const group = svg.selectAll('g')
.data(data)
.enter()
.append('g');

group.attr('transform', (d) => {
    const coordX = scaleX(d[0]);
    const coordY = scaleY(d[1]);
    return `translate(${coordX}, ${coordY})`;
});

const circle = group.append('circle');

circle.attr('cx', 0)
.attr('cy', 0)
.attr('r', (d) => d[2]);

const text = group.append('text');

text.attr('x', d => d[2])
.attr('y', 0)
.text(d=> `[${d[0]}, ${d[1]}]`);

// d3.axis.bottom(scaleX); d3 v3
const xAxis = d3.axisBottom(scaleX);

const groupAxisX = svg.append('g');

groupAxisX
.attr('transform', `translate(0, ${height - sizeAxisX })`)
.call(xAxis);

const yAxis = d3.axisRight(scaleY);

const groupAxisY = svg.append('g');

groupAxisY
.call(yAxis);