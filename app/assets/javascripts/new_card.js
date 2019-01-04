$(document).on("turbolinks:load", function() {
  let form = document.querySelector('form[id="new_user_card"]');
  if (!form) {
    return;
  }

  form.addEventListener("submit", function(event) {
    event.preventDefault();

    $.ajax({
      type: this.method, //post
      url: this.action, //user_cards
      data: $(this).serialize(),
      success: function(resp) {
        if (resp.includes("error")) {
          $("#card_submit").prop("disabled", false);
          $("#error-container").html(resp);
        } else {
          $("#new_user_card")[0].reset();
          $("#error-container").html("");
          $("#card_submit").prop("disabled", false);
          $("#cards-container").append(resp);
        }
      }
    });
  });
});
