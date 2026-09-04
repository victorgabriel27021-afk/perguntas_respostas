import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "fileName"]

  updateFileName() {
    if (this.inputTarget.files.length > 0) {
      this.fileNameTarget.textContent = this.inputTarget.files[0].name
    }
  }
}