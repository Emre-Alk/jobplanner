import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="tablepost-subscription"
export default class extends Controller {
  static values = {
    userId: Number
   }
  static targets = ["insert"]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: 'TablepostChannel', id: this.userIdValue },
      { received: data => {
        if (data.message == "partial") {
          this.#insertPost(data)
        } else {
          this.fetchPost(data)
        }
        }
      }
    )
  }
  fetchPost(data) {
    fetch(`/posts/${data.id}/render_post_partial`)
  }

// data c'est instance
  #insertPost(data) {
    const postHTML = data.html
    const oldPost = document.getElementById(`${data.post_id}`)
    if (oldPost) {
      oldPost.outerHTML = postHTML
    } else {
      this.insertTarget.insertAdjacentHTML("beforeend", postHTML)
      this.insertTarget.scrollTo(0, this.insertTarget.scrollHeight)
    }
  }
}
