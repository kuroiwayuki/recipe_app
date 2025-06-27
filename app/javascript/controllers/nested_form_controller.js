console.log("nested_form_controller.js loaded")
import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="nested-form"
export default class extends Controller {
  connect() {
    console.log("NestedFormController connected")
  }
}
