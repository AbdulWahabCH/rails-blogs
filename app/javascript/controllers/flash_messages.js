export function showFlashMessages() {
  const flashMessages = document.getElementById('flash-messages');

  if (flashMessages) {
    const notice = flashMessages.querySelector('.notice');
    const alert = flashMessages.querySelector('.alert');

    // Check visibility of messages
    const noticeVisible = notice && notice.textContent.trim() !== "";
    const alertVisible = alert && alert.textContent.trim() !== "";

    // Show flash messages only if there is at least one visible message
    if (noticeVisible || alertVisible) {
      flashMessages.style.display = 'block'; // Show the container

      // Show notice if it exists and is visible
      if (noticeVisible) {
        notice.style.display = 'block';
        flashMessages.classList.remove('opacity-0'); // Show the container
        flashMessages.classList.add('opacity-100'); // Show notice
        setTimeout(() => {
          notice.style.display = 'none';
          flashMessages.classList.add('opacity-0'); // Show the container
          // Hide notice
          // Hide flashMessages if no alerts are present
          if (!alertVisible) flashMessages.style.display = 'none';
        }, 3000);
      }

      // Show alert if it exists and is visible
      if (alertVisible) {
        alert.style.display = 'block';
        flashMessages.classList.remove('opacity-0'); // Show the container
        flashMessages.classList.add('opacity-100'); // Show alert
        setTimeout(() => {
          alert.style.display = 'none';
          flashMessages.classList.add('opacity-0'); // Show the container
          // Hide alert
          // Hide flashMessages if no notices are present
          if (!noticeVisible) flashMessages.style.display = 'none';
        }, 3000);
      }
    } else {
      flashMessages.style.display = 'none'; // Hide if neither is present
    }
  }
}
