$(function() {
  $(".js-view-cards").on("click", function() {
    var x = document.getElementById("user_cards");
    if (x.style.display === "none") {
        x.style.display = "block";
    }
    var id = $(this).data("id");

    $.get("/users/" + id + "/user_cards.json", function(data) {

      var complete = `
      <fieldset>

      <legend><h3> ${data[0].user.name}'s Cards:</h3></legend>
      <button type="button" onclick="hideCards()" >Hide Cards</button>
      `
      data.forEach(function(card) {
        const markup = new Card(card).html()
        complete += markup
      });
      complete += `</fieldset>`
      $("#user_cards").html(complete)
    });
  });
});

function hideCards() {
  var x = document.getElementById("user_cards");
  if (x.style.display === "none") {
      x.style.display = "block";
  } else {
      x.style.display = "none";
  }
}

class Card {
  constructor(card) {
    this.id = card.id;
    this.name = card.magic_card_name;
    this.user_id = card.user_id;
    this.magic_card_id = card.magic_card_id;
    this.image_url = card.magic_card.image_url;
    this.quantity = card.quantity;
    this.quality = card.quality;
    this.value = card.value;
  }

  html() {

    let image = `<img src="` + this.image_url + `" style="float:right"`
    if (!this.image_url){
      image = `<img src="placeholder.jpg" style="float:right"`
    }

    let result = `
      <div id='card_${this.id}'>
        <fieldset>
          <legend><h4> ${this.name}

          <form method='Get' action='/magic_cards/` + this.magic_card_id + `' form={ style="display:inline-block"}>
             <input value='View Details' type='submit' />
           </form>

          <form method='Update' action='/user_cards/` + this.id + `/edit' form={ style="display:inline-block"}>
             <input value='Edit' type='submit' />
           </form>

          <form method='post' action='/user_cards/${this.id}' data-remote='true' form={ style="display:inline-block"}>
             <input name='_method' value='delete' type='hidden' />
             <input value='Delete' type='submit' />
           </form>
          </h4></legend>

          ` + image + `

          <p>
            Quantity:</br>
            <textarea disabled="disabled" name="user_card[quantity]" id="user_card_quantity">`+ this.quantity + `</textarea>

            </br></br>

            Value(s):</br>
            <textarea disabled="disabled" name="user_card[value]" id="user_card_value">`+ this.value + `</textarea>

            </br></br>

            Quality:</br>
            <textarea disabled="disabled" name="user_card[quality]" id="user_card_quality">`+ this.quality + `</textarea>
          </p>
        </fieldset>
      </div>
    `
    return result
  }
}
