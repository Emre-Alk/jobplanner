import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="comment"
export default class extends Controller {
  static targets = ['form', 'dataForm', 'insert']
  static values = {
    postId: Number
  }

  connect() {
    console.log('comment controller')
  }

  displayForm() {
    this.formTarget.classList.toggle('hidden')
  }

  update(event) {
    // debugger
    event.preventDefault()
    const url = `/posts/${this.postIdValue}`
    const details = {
      method: 'PATCH',
      headers: { "Accept": "text/plain",
        "X-CSRF-Token": document
        .querySelector('meta[name="csrf-token"]')
        .getAttribute("content"),
      },
      body: new FormData(this.dataFormTarget)
    }
    console.log(new FormData(this.dataFormTarget))
    console.log(this.dataFormTarget);

    fetch(url, details)
    .then(response => response.text())
    .then((data) => {
      console.log(typeof data);
      // let comment = data.slice(5, -6)
      this.insertTarget.innerHTML = data
      this.formTarget.classList.toggle('hidden')
    })

  }
}
