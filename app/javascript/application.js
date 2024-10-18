// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import { Turbo } from "@hotwired/turbo-rails"


import { showFlashMessages } from "./controllers/flash_messages";
import { inline_form_edit } from "./controllers/inline_comment";
import { notificationChannel } from './channels/notification_channel';

document.addEventListener('turbo:load', () => {
  inline_form_edit();
  showFlashMessages();
  notificationChannel;
});
