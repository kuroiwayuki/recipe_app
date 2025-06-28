import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container", "template"]
  index = 0

  connect() {
    console.log("RecipetItemsControllerは開けてるよ💩")
    this.index = this.containerTarget.children.length
  }

  add() {
    console.log("addしろカス💩")
    const template = this.templateTarget.innerHTML
    const html = template.replace(/NEW_RECORD/g, this.index)
    console.log(this.containerTarget)
    this.containerTarget.insertAdjacentHTML("beforeend", html)
    this.index++
  }
  remove(event) {
    event.preventDefault()
    const item = event.target.closest(".recipet-item")
    console.log(item,"確認")
    item.querySelector("input[name*='_destroy']").value = "1"
    item.style.display = "none"
  }
}
