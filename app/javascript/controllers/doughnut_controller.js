import { Controller } from "@hotwired/stimulus"
import { Chart, registerables } from 'chart.js'
Chart.register(...registerables);

// Connects to data-controller="chart"
export default class extends Controller {
  static targets = ["donut"]
  static values = {
    data: Object,
    colors: Array
  }

  connect() {

    let counts = [];
    let colors = [];

    for(let key in this.dataValue) {
        counts.push(this.dataValue[key].count);
        colors.push(this.dataValue[key].color);
    }

    const data = {
      labels: Object.keys(this.dataValue),
      datasets: [{
        label: 'Statuts',
        data: counts,
        backgroundColor: colors,
        hoverOffset: 4
      }]
    };

    const chartOptions = {
      plugins: {
        legend: {
          position: 'right' // This positions the legend at the bottom
        },
        // title: {
        //   display: true,
        //   text: 'Job applications status'
        // }
      }
    };

    new Chart(this.donutTarget, {
      type: 'doughnut',
      data: data,
      options: chartOptions
    });
   }


}
