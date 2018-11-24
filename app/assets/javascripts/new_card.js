$(document).on("turbolinks:load", function(){
  let form = document.querySelector('form[id="new_user_card"]');
  if(!form){
    return
  }

  form.addEventListener('submit', function(event) {
      event.preventDefault();

      $.ajax({
        type: this.method,
        url: this.action,
        data: $(this).serialize(),
        success: function(resp){
          $("#new_user_card")[0].reset()
          $('#card_submit').prop('disabled', false);
          $("#cards-container").append(resp);
        }
      });

  });
});
