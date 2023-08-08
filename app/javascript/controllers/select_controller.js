import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js";

// Connects to data-controller="showing-timeslots"
export default class extends Controller {
  static targets = ["tSelect"]
  connect() {
    console.log("Hello, World!")
  }

  change(event) {
    let select = event.target.selectedOptions[0].value
    let target = this.tSelectTarget.id
    this.url = `/showings/free_timeslots?target=${target}&cinema_id=${select}`

    fetch(this.url, {
      headers: {
        Accept: "text/vnd.turbo-stream.html"
      }
    })
    .then(response => response.text())
    .then(html => Turbo.renderStreamMessage(html))

    //get(`/showings/free_timeslots?target=${target}&cinema_id=${select}`, {
    //  responseKind: "turbo-stream"
    //})
  }
}
