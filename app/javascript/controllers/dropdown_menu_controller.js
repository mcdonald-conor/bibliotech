// import { Controller } from "@hotwired/stimulus"

// // Connects to data-controller="dropdown-menu"
// export default class extends Controller {
//   static targets = ["dropdownMenu"]
//   connect() {
//     this.showDropdownEventListeners()
//     this.hideDropdownEventListeners()
//   }
// }

// showDropdownEventListeners() {
//   this.element.querySelectorAll('.book-cover-container').forEach(container => {
//     container.addEventListener('mouseenter', this.showDropdown.bind(this))
//   })
// }

// hideDropdownEventListeners() {
//   this.element.querySelectorAll('.book-cover-container').forEach(container => {
//     container.addEventListener('mouseleave', this.hideDropdown.bind(this))
//   })
// }

// showDropdown(event) {
//   const bookCoverContainer = event.currentTarget
//   const dropdownMenu = bookCoverContainer.querySelector(this.dropdownMenuTarget)
//   dropdownMenu.style.display = 'block'
// }

// hideDropdown(event) {
//   const bookCoverContainer = event.currentTarget
//   const dropdownMenu = bookCoverContainer.querySelector(this.dropdownMenuTarget)
//   dropdownMenu.style.display = 'none'
// }
// }


// import { Controller } from "@hotwired/stimulus"

// // Connects to data-controller="dropdown-menu"
// export default class extends Controller {
//   connect() {
//     // This method will automatically be called when the controller is connected to the DOM.
//     // You can add additional logic here if needed.
//   }

//   // Optionally, you can add methods to handle menu interactions here.
// }

//

// import { Controller } from "@hotwired/stimulus"

// // Connects to data-controller="dropdown-menu"
// export default class extends Controller {
//   static targets = ["dropdownButton"]

//   connect() {
//     this.dropdownButtonTargets.forEach(button => {
//       button.addEventListener("click", this.updateCategory.bind(this))
//     })
//   }

//   updateCategory(event) {
//     const button = event.currentTarget
//     const category = button.textContent.trim()
//     const bookId = button.closest(".book-cover-container").dataset.bookId

//     fetch(`/books/${bookId}/update_category`, {
//       method: "POST",
//       headers: {
//         "Content-Type": "application/json",
//         "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
//       },
//       body: JSON.stringify({ category })
//     }).then(response => {
//       if (response.ok) {
//         alert(`Book category updated to ${category}`)
//         // Optionally, refresh the page or update the UI dynamically
//       } else {
//         alert("Failed to update book category")
//       }
//     })
//   }
// }

// import { Controller } from "@hotwired/stimulus"

// // Connects to data-controller="dropdown-menu"
// export default class extends Controller {
//   static targets = ["dropdownButton"]

//   connect() {
//     this.dropdownButtonTargets.forEach(button => {
//       button.addEventListener("click", this.updateCategory.bind(this))
//     })
//   }

//   updateCategory(event) {
//     const button = event.currentTarget
//     const category = button.getAttribute("data-category")
//     const bookCard = button.closest(".library-card")
//     bookCard.setAttribute("data-category", category)
//     alert(`Book category updated to ${category}`)
//   }
// }

// import { Controller } from "@hotwired/stimulus"

// // Connects to data-controller="dropdown-menu"
// export default class extends Controller {
//   static targets = ["dropdownButton"]

//   connect() {
//     this.dropdownButtonTargets.forEach(button => {
//       button.removeEventListener("click", this.updateCategory.bind(this)) // Remove any existing listener
//       button.addEventListener("click", this.updateCategory.bind(this)) // Add the new listener
//     })
//   }

//   updateCategory(event) {
//     const button = event.currentTarget
//     const category = button.getAttribute("data-category")
//     const bookCard = button.closest(".library-card")
//     bookCard.setAttribute("data-category", category)
//     alert(`Book category updated to ${category}`)
//   }
// }
