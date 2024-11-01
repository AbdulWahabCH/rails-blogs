// app/javascript/channels/notification_channel.js
import consumer from "./consumer"

export const notificationChannel = consumer.subscriptions.create("NotificationChannel", {
    connected() {
        console.log("Connected to NotificationChannel");
    },

    disconnected() {
        console.log("Disconnected from NotificationChannel");
    },

    received(data) {
        // console.log("Received data: ", data);

        // const notificationsList = document.getElementById('notification-box');
        // const notificationItem = document.createElement('span');
        // notificationItem.innerHTML = data.message;
        // notificationsList.appendChild(notificationItem);

        console.log("Received data: ", data);

        const notificationsList = document.getElementById('notification-list');
        const notificationItem = document.createElement('div');
        notificationItem.classList.add('notification-item', 'py-2');
        notificationItem.innerHTML = `
          <p class="font-semibold">${data.actor_username}</p>
          <p class="text-gray-600">${data.action}</p>
          <p class="text-xs text-gray-400">${data.time_ago} ago</p>
        `;

        notificationsList.prepend(notificationItem);
    },

    rejected() {
        console.error("Failed to connect to NotificationChannel");
    }
});
