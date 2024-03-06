import { Controller } from "@hotwired/stimulus"
import { Chart } from 'chart.js'

// Connects to data-controller="chart"
export default class extends Controller {
  static targets = [ "chart" ]

  connect() {
    console.log("Hello, Stimulus!", this.element);
    console.log(Chart);
  //   new Chart(chartTarget, {
  //     type: 'doughnut',
  //     data: data,
  //   });

  //   const data = {
  //     labels: [
  //       'Red',
  //       'Blue',
  //       'Yellow'
  //     ],
  //     datasets: [{
  //       label: 'My First Dataset',
  //       data: [300, 50, 100],
  //       backgroundColor: [
  //         'rgb(255, 99, 132)',
  //         'rgb(54, 162, 235)',
  //         'rgb(255, 205, 86)'
  //       ],
  //       hoverOffset: 4
  //     }]
  //   };
   }


}
