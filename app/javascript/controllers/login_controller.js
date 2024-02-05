import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "email", "password" ]

  connect() {
    console.log("Hello, Stimulus! 🎉")
  }

  login() {
    console.log("You clicked the login button!")
    console.log("Email:", this.emailTarget.value)
    console.log("Password:", this.passwordTarget.value)
  }
}
