import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sort-table"
export default class extends Controller {
  static targets = [ 'tbody', 'thead' ];

  connect() {
  }

  sort(event) {
    let direction = "asc";
    let column = event.target.id;
    const icon = event.target.querySelector('svg');

    if (icon) {
      direction = icon.dataset.state === "asc" ? "desc" : "asc";
    }

    const url = `posts/sort/?column=${column}&direction=${direction}`
    const details = {
      method: 'GET',
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document
          .querySelector('meta[name="csrf-token"]')
          .getAttribute("content"),
      },
    };

    if (column != '') {
      this.iconsHandler(column);

      fetch(url, details)
      .then(response => response.json())
      .then((data) => {
        this.tbodyTarget.innerHTML = data.html_table
      })
    }
  }

  iconsHandler(id) {
    this.theadTarget.querySelectorAll('th').forEach(headerCell => {
      if(headerCell.querySelector('span').id != id){
        this.addDefaultIcon(headerCell);
      }
      else{
        this.updateIcon(headerCell);
      }
    });
  }

  addDefaultIcon(headerCell) {
    headerCell.querySelectorAll('svg').forEach(icon => icon.remove());
    headerCell.querySelector('div').innerHTML += `<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-chevrons-up-down"><path d="m7 15 5 5 5-5"/><path d="m7 9 5-5 5 5"/></svg>`;
  }

  updateIcon(headerCell) {
    const iconId = headerCell.querySelector('svg').dataset.state;

    headerCell.querySelectorAll('svg').forEach(icon => icon.remove());

    if (iconId === 'asc') {
      headerCell.querySelector('div').innerHTML += `<svg data-state='desc' xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-chevron-up"><path d="m18 15-6-6-6 6"/></svg>`;
    } else {
      headerCell.querySelector('div').innerHTML += `<svg data-state='asc' xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-chevron-down"><path d="m6 9 6 6 6-6"/></svg>`;
    }
  }
}
