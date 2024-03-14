import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="status"
export default class extends Controller {
  static values = {
    postId: Number
  };
  static targets = [ 'dropdown', 'current', 'menu', 'insert' ];

  connect() {
  }

  edit() {
    this.dropdownTarget.classList.toggle('hidden')
  }

  update(event) {
    const status = event.target.outerText.toLowerCase();
    const url = `/posts/${this.postIdValue}`
    const details = {
      method: 'PATCH',
      headers: {
        "Content-Type": "application/json",
        "Accept" : "application/json",
        "X-CSRF-Token": document
          .querySelector('meta[name="csrf-token"]')
          .getAttribute("content"),
      },
      body: JSON.stringify( { content: status } )
    }
    const button = this.insertTarget

    fetch(url, details)
    .then(response => response.json())
    .then((data) =>
    button.innerHTML = data.html_status,
    this.dropdownTarget.classList.toggle('hidden'),
    )
  }
}
