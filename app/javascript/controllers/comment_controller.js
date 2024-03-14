import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="comment"
export default class extends Controller {
  static targets = ['form', 'dataForm', 'insert', 'button']
  static values = {
    postId: Number
  }

  connect() {
    console.log('comment controller')
  }

  displayForm() {
    this.formTarget.classList.toggle('hidden')
    this.insertTarget.querySelector('.trix-content').classList.toggle('hidden')
  }

  update(event) {
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

    fetch(url, details)
    .then(response => response.text())
    .then((data) => {

      this.insertTarget.innerHTML = data
      this.insertTarget.querySelector('.trix-content').classList.remove('hidden')
      this.formTarget.classList.toggle('hidden')

      const div = document.createElement('div')
      div.innerHTML = data
      const word = div.innerText.trim()

      if (Object.keys(word).length === 0 ) {
        console.log('vide');
        this.buttonTarget.innerText = 'Add a note'
      } else {
        console.log('no vide');
        this.buttonTarget.innerText = 'Edit note'
      }
    })
  }
}
