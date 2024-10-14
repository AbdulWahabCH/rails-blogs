import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }


document.addEventListener('DOMContentLoaded', () => {
    const flashMessages = document.getElementById('flash-messages');
  
    if (flashMessages) {
      // Show the flash messages
      flashMessages.style.display = 'block';
  
      // Set a timeout to hide the messages after a few seconds
      setTimeout(() => {
        flashMessages.style.display = 'none';
      }, 3000); // Adjust the time (in milliseconds) as needed
    }
  });
  