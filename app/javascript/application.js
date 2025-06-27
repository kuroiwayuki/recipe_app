import "@hotwired/turbo-rails"
console.log("✅ Turbo loaded")

import { Application } from "@hotwired/stimulus"
console.log("✅ Stimulus imported")

import HelloController from "./controllers/hello_controller"

const application = Application.start()
application.register("hello", HelloController)

window.Stimulus = application
console.log("✅ Stimulus started")
