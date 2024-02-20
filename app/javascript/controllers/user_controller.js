import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "deleteButton" ]

  connect() {
    console.log("User actions")
  }

  navigate({ params }) {
    window.location.href = `/users/${params.id}/edit`
  }

  delete() {
    this.deleteButtonTarget.click()
  }
}
