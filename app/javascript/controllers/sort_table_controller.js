import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sort-table"
export default class extends Controller {
  static targets = [ 'tbody', 'thead' ];

  connect() {
  }

  sort(event) {
    let direction = "desc";

    if(event.target.querySelector('svg') === null){
      direction = "desc";
    } else if(event.target.querySelector('svg').id === "desc"){
      direction = "asc";
    } else if (event.target.querySelector('svg').id === "asc"){
      direction = "desc";
    }

    const url = `posts/sort/?column=${event.target.id}&direction=${direction}`
    const details = {
      method: 'GET',
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document
          .querySelector('meta[name="csrf-token"]')
          .getAttribute("content"),
      },
    };

    this.iconsHandler(event.target.id);

    fetch(url, details)
    .then(response => response.json())
    .then((data) => {
      this.tbodyTarget.innerHTML = data.html_table
    })
  }

  iconsHandler(id) {
    this.theadTarget.querySelectorAll('th').forEach(headerCell => {
      if(headerCell.querySelector('div').id != id){
        headerCell.querySelectorAll('svg').forEach(icon => icon.remove());
        headerCell.querySelector('div').innerHTML += `
          <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
            <path stroke-linecap="round" stroke-linejoin="round" d="M8.25 15 12 18.75 15.75 15m-7.5-6L12 5.25 15.75 9" />
          </svg>`;
      }
      else{
        if (headerCell.querySelector('svg').id === 'asc') {
          headerCell.querySelectorAll('svg').forEach(icon => icon.remove());
          headerCell.querySelector('div').innerHTML += `
            <svg id="asc" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
              <path stroke-linecap="round" stroke-linejoin="round" d="m4.5 15.75-7.5-7.5-7.5 7.5" />
            </svg>`;
        } else {
          headerCell.querySelectorAll('svg').forEach(icon => icon.remove());
          headerCell.querySelector('div').innerHTML += `
            <svg id="desc" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
              <path stroke-linecap="round" stroke-linejoin="round" d="m19.5 8.25-7.5 7.5-7.5-7.5" />
            </svg>`;
        }
      }
    });
  }
}
