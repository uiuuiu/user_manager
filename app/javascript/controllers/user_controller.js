import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    console.log("User actions")
  }

  navigate({ params }) {
    window.location.href = `/users/${params.id}/edit`
  }
}
