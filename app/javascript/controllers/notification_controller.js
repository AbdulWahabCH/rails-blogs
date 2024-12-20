import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ['notificationBox']

    foo() {
        this.notificationBoxTarget.classList.toggle('hidden');
    }
}