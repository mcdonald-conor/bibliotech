import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="scroller"
export default class extends Controller {
  connect() {

  }

  backToTop() {
    console.log('scrolling back to top')
    document.body.scrollTop = 0;
    document.documentElement.scrollTop = 0;
  }
}
