import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ['notificationBox']

    foo() {
        this.notificationBoxTarget.classList.toggle('hidden');
    }
}

// export function notification_click() {
//     document.getElementById('notification-icon').addEventListener('click', function () {
//         const box = document.getElementById('notification-box');
//         box.classList.toggle('hidden');
//         alert('notifiation clicked')
//     });

// }