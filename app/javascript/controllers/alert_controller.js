import { Controller } from "@hotwired/stimulus"
import Swal from "sweetalert2"

// Connects to data-controller="alert"
export default class extends Controller {
  connect() {
  }
  initSweetalert(event) {
    // Prevent the form to be submited after the submit button has been clicked
    console.log("Hello")

    Swal.fire({title: "Creating your next-gen reading list now!", imageUrl: "../../assets/images/g0R5.gif", imageWidth: 400, imageHeight: 400, imageAlt: "Loading gif" });
}
}
