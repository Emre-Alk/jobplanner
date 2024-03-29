import { Controller } from "@hotwired/stimulus"
import { Chart, registerables } from 'chart.js'
Chart.register(...registerables);

// Connects to data-controller="chart"
export default class extends Controller {
  static targets = ["line"]
  static values = {
    data: Object
  }

  connect() {

    const sortedKeys = Object.keys(this.dataValue).sort((a, b) => new Date(a) - new Date(b));
    const sortedValues = sortedKeys.map(key => this.dataValue[key]);

    const data = {
      labels: sortedKeys,
      datasets: [{
        label: 'candidaté',
        data: sortedValues,
        fill: false,
        borderColor: '#38a169',
        tension: 0.1
      }]
    };

    const chartOptions = {
      plugins: {
        legend: {
          position: 'right'
        }
      },
      scales: {
        y: {
            offset: true,
            type: 'linear',
            min: 0,
            ticks: {
              stepSize: 1,
            },
            beginAtZero: true
        },
      },
      maintainAspectRatio: false,
      responsive: true,
    };

    new Chart(this.lineTarget, {
      type: 'line',
      data: data,
      options: chartOptions
    });
   }

}
