import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets =["link"]
  show() {
    this.linkTarget.classList.toggle("hidden")
  }
  connect(){
    console.log("test")
  }
}
