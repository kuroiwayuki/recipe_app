import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container", "template"]
  index = 0

  connect() {
    console.log("RecipetItemsController connected💩")
    this.index = this.containerTarget.children.length
  }

  add() {
    console.log("addしろカス💩")
    const template = this.templateTarget.innerHTML
    const html = template.replace(/NEW_RECORD/g, this.index)
    console.log(this.containerTarget)
    this.containerTarget.insertAdjacentHTML("afterbegin", html)
    this.index++
  }
}
