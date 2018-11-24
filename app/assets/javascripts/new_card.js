$(function() {
  let form = document.querySelector('form[id="new_user_card"]');
  form.addEventListener('submit', function(event) {
      event.preventDefault();

      let name = this.user_card_magic_card_name.value;
      let quantity = this.user_card_quantity.value;
      let quality = this.user_card_quality.value;
      let value = this.user_card_value.value;
      let url = this.action;
      let authenticity_token = this.authenticity_token.value;


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
})
