// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import { showFlashMessages } from "./controllers/flash_messages";
import { inline_form_edit } from "./controllers/inline_comment";

document.addEventListener('turbo:load', () => {
  inline_form_edit();
  showFlashMessages();
});
