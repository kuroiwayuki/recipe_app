import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="category-modal"
export default class extends Controller {

  static targets = ["backGround"]
  connect() {
    console.log("モーダルとりあえず開けてる💩💩")
  }

  close(event) {
    console.log(event.detail)
    if (event.detail.fetchResponse.succeeded) {
      console.log("成功だよーん💩")
      this.element.remove()
    }
  }
  

  closeModal(event) {
    this.backGroundTarget.classList.add("hidden");
  }

  closeBackground(event) {
    console.log("モーダルの背景クリックされたよ💩")
    console.log(event.target)
    console.log(this.backGroundTarget)
    console.log(event.target === this.backGroundTarget)
    if (event.target === this.backGroundTarget) {
      this.closeModal(event);
    }
  }
}
