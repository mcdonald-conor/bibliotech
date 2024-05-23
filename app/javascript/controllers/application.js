import { Application } from "@hotwired/stimulus"
//Stimulus.register("books", BooksController)

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
