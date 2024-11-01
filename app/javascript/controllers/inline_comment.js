export function inline_form_edit() {
  document.querySelectorAll('.edit-comment-link').forEach(link => {
    link.addEventListener('click', function (event) {
      event.preventDefault();
      const commentId = this.dataset.commentId;
      const commentDiv = document.getElementById(`comment-${commentId}`);
      const editForm = document.getElementById(`edit-comment-form-${commentId}`);

      commentDiv.style.display = 'none'; // Hide the comment
      editForm.style.display = 'block'; // Show the edit form
    });
  });
  document.querySelectorAll('.update-button').forEach(button => {
    button.addEventListener('click', function (e) {
      // e.preventDefault();
      const commentId = this.closest('form').id.split('-').pop(); // Get the comment ID from the form ID
      const commentDiv = document.getElementById(`comment-${commentId}`);
      const editForm = document.getElementById(`edit-comment-form-${commentId}`);

      commentDiv.style.display = 'block';
      editForm.style.display = 'none';

      const flashMessages = document.getElementById('flash-messages');
      if (flashMessages) {
        flashMessages.style.display = 'block'; // Show flash messages
        flashMessages.innerHTML = '<p class="notice">Comment updated successfully!</p>'; // Update the flash message text

        setTimeout(() => {
          flashMessages.style.display = 'none';
        }, 3000);
      }
    });
  });

  document.querySelectorAll('.cancel-edit').forEach(link => {
    link.addEventListener('click', function (event) {
      event.preventDefault();
      const commentId = this.closest('form').id.split('-').pop();
      const commentDiv = document.getElementById(`comment-${commentId}`);
      const editForm = document.getElementById(`edit-comment-form-${commentId}`);

      commentDiv.style.display = 'block'; // Show the comment
      editForm.style.display = 'none'; // Hide the edit form
    });
  });
}