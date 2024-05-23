import { Application } from "@hotwired/stimulus"
import BooksController from "./books_controller"
//Stimulus.register("books", BooksController)

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
