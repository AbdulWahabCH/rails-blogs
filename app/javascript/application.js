// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import { showFlashMessages } from "./controllers/flash_messages";

document.addEventListener('turbo:load', () => {
  showFlashMessages();
});
