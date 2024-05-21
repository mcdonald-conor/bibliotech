// app/javascript/controllers/library_controller.js
import { Controller } from "@hotwired/stimulus"
// import Rails from '@rails/ujs'

export default class extends Controller {
  static targets = ["form", "button"]
  static values = {
    url: String
  }

  connect() {
    console.log('stimulus books controller connected')
  }

  add(event) {
    event.preventDefault()
    console.log("let's add the book to the library")

    const url = this.urlValue
    const data = new FormData(this.formTarget)
    const csrfToken = document.querySelector('meta[name="csrf-token"]').content
    console.log({ data })

    fetch(url, {
      method: "POST",
      header: {
        "X-CSRF-Token": csrfToken,
        "Content-Type": "application/json",
        "Accept": "application/json"
      },
      credentials: 'same-origin',
      body: data
    })
      .then((response) => response.json())
      .then(data => {
        if (data.status === "ok") {
          const buttonElement = document.createElement('div')
          buttonElement.innerHTML = `<button class="results-button">Saved!</button>`
          console.log('saved: replacing button')
          this.buttonTarget.replaceWith(buttonElement)
        } else {
          console.log('not saved: replacing button')
          const buttonElement = document.createElement('div')
          buttonElement.innerHTML = `<button class="results-button">Something went wrong</button>`
          this.buttonTarget.replaceWith(buttonElement)
        }
      })

    // const bookId = this.data.get("bookId")



    // axios.post(`/books/${bookId}/save`)
    //   .then(response => {
    //     // Handle success, update the UI accordingly
    //     this.buttonTarget.innerText = "Added"
    //     this.buttonTarget.disabled = true
    //   })
    //   .catch(error => {
    //     // Handle error
    //     console.error("There was an error adding the book!", error)
    //   })
  }
}
