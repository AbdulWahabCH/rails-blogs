export function inline_form_edit(){
    document.querySelectorAll('.edit-comment-link').forEach(link => {
        link.addEventListener('click', function(event) {
          event.preventDefault();
          const commentId = this.dataset.commentId;
          alert(commentId)
          const commentDiv = document.getElementById(`comment-${commentId}`);
          const editForm = document.getElementById(`edit-comment-form-${commentId}`);
    
          commentDiv.style.display = 'none'; // Hide the comment
          editForm.style.display = 'block'; // Show the edit form
        });
      });
    
      // Optional: Add functionality for the cancel button
      document.querySelectorAll('.cancel-edit').forEach(link => {
        link.addEventListener('click', function(event) {
          event.preventDefault();
          const commentId = this.closest('form').id.split('-').pop();
          const commentDiv = document.getElementById(`comment-${commentId}`);
          const editForm = document.getElementById(`edit-comment-form-${commentId}`);
    
          commentDiv.style.display = 'block'; // Show the comment
          editForm.style.display = 'none'; // Hide the edit form
        });
      });
}