import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets =["link", "page"]
  show() {
    this.linkTarget.classList.toggle("hidden")
    this.pageTarget.classList.toggle("hidden")
  }
  connect(){
    console.log("test")
  }
  close(event) {
    console.log(event.target)
    this.linkTarget.classList.add("hidden")
    this.pageTarget.classList.toggle("hidden")
  }
}
