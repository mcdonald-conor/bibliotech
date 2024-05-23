import { Controller } from "@hotwired/stimulus"
import Swal from "sweetalert2"

// Connects to data-controller="alert"
export default class extends Controller {
  connect() {
  }
  initSweetalert(event) {
    // Prevent the form to be submited after the submit button has been clicked
    console.log("Hello")

    Swal.fire({
      title: "Please wait while we generate your personalised reading list",
      icon: "info",
      //confirmButtonColor: "#F674B4",
      //confirmButtonText: "Can't wait!",
      //padding: "10px",
      //background: "rgba(255,255,255)",
      //color:"rgb(0,0,0)"
     });
}
}
