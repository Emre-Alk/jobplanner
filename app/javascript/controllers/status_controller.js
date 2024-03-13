import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="status"
export default class extends Controller {
  static values = {
    postId: Number
  };
  static targets = [ 'dropdown', 'current', 'menu', 'insert' ];

  connect() {
    console.log('status connected !');
    console.log(this.postIdValue);
    console.log(this.dropdownTarget);
  }

  edit() {
    this.dropdownTarget.classList.toggle('hidden')
  }

  update(event) {
    const status = event.target.outerText.toLowerCase();
    // console.log(status);
    // console.log(this.postIdValue);
    const url = `/posts/${this.postIdValue}`
    console.log(url);
    const details = {
      method: 'PATCH',
      headers: {
        "Content-Type": "application/json",
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
    // console.log(data)
    button.innerHTML = data.html_status,
    this.dropdownTarget.classList.toggle('hidden'),
    )
  }
}
