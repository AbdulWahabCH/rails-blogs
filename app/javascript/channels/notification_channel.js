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
        console.log("Received data: ", data);

        const notificationsList = document.getElementById('notification-box');
        const notificationItem = document.createElement('div');
        notificationItem.innerHTML = data.message; // Assuming data contains a message
        notificationsList.appendChild(notificationItem);
    },

    rejected() {
        console.error("Failed to connect to NotificationChannel");
    }
});
