import { Controller } from "@hotwired/stimulus"
import { Chart, registerables } from 'chart.js'
Chart.register(...registerables);

// Connects to data-controller="chart"
export default class extends Controller {
  static targets = ["donut"]

  connect() {
    console.log("Hello, Stimulus!", this.element);
    console.log(this.donutTarget);

    const data = {
      labels: [
        'pending',
        'applied',
        'rejected'
      ],
      datasets: [{
        label: 'My First Dataset',
        data: [300, 50, 100],
        backgroundColor: [
          'rgb(255, 99, 132)',
          'rgb(54, 162, 235)',
          'rgb(255, 205, 86)'
        ],
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
