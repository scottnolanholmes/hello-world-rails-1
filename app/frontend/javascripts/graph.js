import 'chart.js';

export default {
  Line(id) {
    const element = document.getElementById(id);
    const ctx     = element.getContext('2d');
    const data    = element.dataset;
    let ticks     = data.ticks;

    ticks = (!data.ticks) ?
       {
        beginAtZero: true,
        min: 0,
        max: 100
      } : JSON.parse(data.ticks)

    new Chart(ctx, {
        type: 'line',
        data: {
            labels: JSON.parse(data.labels),
            datasets: [{
                label: data.label,
                fill: false,
                data: JSON.parse(data.values),
                backgroundColor: 'rgba(75,192,192,1)',
                borderColor: 'rgba(75,220,220,1)',
            }]
        },
        options: {
        responsive: true,
        tooltips: {
          mode: 'index',
          intersect: false,
        },
        hover: {
          mode: 'nearest',
          intersect: true
        },
        scales: {
          xAxes: [{
            display: false,
            scaleLabel: {
              display: true,
              labelString: data.xlabel
            }
          }],
          yAxes: [{
            display: true,
            scaleLabel: {
              display: true,
              labelString: data.ylabel
            },
            ticks: ticks
          }]
        }
      }
    });
  }
}
