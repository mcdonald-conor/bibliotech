// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"
import "@hotwired/stimulus"

import ScrollerController from "./controllers/scroller_controller.js"

window.Stimulus = Application.start();

Stimulus.register("scroller", ScrollerController);