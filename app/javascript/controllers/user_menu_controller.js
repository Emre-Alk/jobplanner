import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets =["link", "page"]
  show() {
    this.linkTarget.classList.toggle("hidden")
    this.pageTarget.classList.toggle("hidden")
  }
  connect(){
  }
  close(event) {
    this.linkTarget.classList.add("hidden")
    this.pageTarget.classList.toggle("hidden")
  }
}
