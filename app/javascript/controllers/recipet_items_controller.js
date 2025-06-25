import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container", "template"]
  index = 0

  connect() {
    // ページ初期表示時に1行追加しておく（任意）
    this.add()
  }

  add() {
    const content = this.templateTarget.innerHTML.replace(/__INDEX__/g, this.index++)
    this.containerTarget.insertAdjacentHTML("beforeend", content)
  }
}
