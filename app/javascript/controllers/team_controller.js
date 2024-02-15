import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    console.log("Team actions")
  }

  navigate({ params }) {
    window.location.href = `/teams/${params.id}/edit`
  }
}
