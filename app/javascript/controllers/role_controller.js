import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "checkbox" ];

  connect() {
    console.log("Role actions")
  }

  navigate({ params }) {
    window.location.href = `/roles/${params.id}/edit`
  }

  toggle({ target }) {
    console.log(target)
    // const id = target.dataset.id
    // const checked = target.checked
    // const url = `/roles/${id}/toggle`
    // fetch(url, {
    //   method: "PATCH",
    //   headers: {
    //     "Content-Type": "application/json",
    //     "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
    //   },
    //   body: JSON.stringify({ role: { active: checked } })
    // })
  }
}
