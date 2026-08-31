import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Sidebar controller funcionando!")
  }

  toggle() {
    this.element.classList.toggle("sidebar-open")
  }
}