import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "deleteButton" ]

  connect() {
    console.log("Team actions")
  }

  navigate({ params }) {
    window.location.href = `/teams/${params.id}/edit`
  }

  delete() {
    this.deleteButtonTarget.click()
  }
}
