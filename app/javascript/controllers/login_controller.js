import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "login", "password" ]

  connect() {
    console.log("Login actions!!")
  }

  login() {
    console.log("You clicked the login button!")
    console.log("login:", this.loginTarget.value)
    console.log("Password:", this.passwordTarget.value)
  }
}
