import "@hotwired/turbo-rails"
import { Application } from "@hotwired/stimulus"
import RecipetItemsController from "./controllers/recipet_items_controller"
import CategoryModalController from "./controllers/category_modal_controller"

console.log("Hello Stimulus ✅")

const application = Application.start()
window.Stimulus = application

application.register("recipet-items", RecipetItemsController) 
application.register("category-modal", CategoryModalController) 

console.log("Stimulus controllers:", window.Stimulus.controllers)
console.log("Stimulus modules:", window.Stimulus.router.modulesByIdentifier)
