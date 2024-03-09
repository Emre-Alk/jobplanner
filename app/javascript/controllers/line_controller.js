import { Controller } from "@hotwired/stimulus"
import { Chart, registerables } from 'chart.js'
Chart.register(...registerables);

// Connects to data-controller="chart"
export default class extends Controller {
  static targets = ["line"]

  connect() {

    const data = {
      labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
      datasets: [{
        label: 'Applied',
        data: [65, 59, 80, 81, 56, 55, 40],
        fill: false,
        borderColor: 'rgb(54, 162, 235)',
        tension: 0.1
      }]
    };

    const chartOptions = {
      plugins: {
        legend: {
          position: 'right' // This positions the legend at the bottom
        }
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
