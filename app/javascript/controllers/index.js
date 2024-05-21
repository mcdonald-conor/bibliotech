// Import and register all your controllers from the importmap under controllers/*
import { application } from "controllers/application"

// Eager load all controllers defined in the import map under controllers/**/*_controller
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

// If you prefer to lazy load controllers as they appear in the DOM, you can use the following lines instead
// (Remember not to preload controllers in the import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)
