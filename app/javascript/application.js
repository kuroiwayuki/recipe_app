import "@hotwired/turbo-rails"
import { Application } from "@hotwired/stimulus"
import RecipetItemsController from "./controllers/recipet_items_controller" // ✅ ファイル名と一致

console.log("Hello Stimulus ✅")

const application = Application.start()
window.Stimulus = application

application.register("recipet-items", RecipetItemsController) // ✅ コントローラ名に合わせて登録

console.log("Stimulus controllers:", window.Stimulus.controllers)
console.log("Stimulus modules:", window.Stimulus.router.modulesByIdentifier)
