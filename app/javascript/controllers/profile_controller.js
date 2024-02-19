import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["input"]

    preview() {
        var input = this.inputTarget
        var files = input.files
        var imgLoc = document.getElementById("Img")
        for (var i = 0; i < files.length; i++) {
            let reader = new FileReader()
            reader.onload = function() {
                let image = document.createElement("img")
                imgLoc.innerHTML = ""
                imgLoc.appendChild(image)
                image.style.height = '5rem'
                image.src = reader.result
            }
            reader.readAsDataURL(files[i])
        }
    }
}
