import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="showing-timeslots"
export default class extends Controller {
  connect() {
    console.log("Hello, World!")
  }

  initialize() {
    this.element.setAttribute("data-action", 
                              "change->showing-timeslots#loadTimeslots")
  }

  loadTimeslots() {
    const selectedCinema = this.element.value
    if (selectedCinema != "")  {
      this.url = `/showings/get_free_timeslots?cinema_id=${selectedCinema}`
      console.log(this.url)
      fetch(this.url, {
        headers: {
          Accept: "text/vnd.turbo-stream.html"
        }
      })
      .then(response => response.text())
      .then(html => Turbo.renderStreamMessage(html))
    }
  }
}
