function getCards() {
  let cardToggleButton = document.getElementById("toggle_cards");
  if ($("#user_cards").html() === "") {

    cardToggleButton.innerText = "Hide Cards";
    let id = $(this).data("id");

    $.get("/users/" + id + "/user_cards.json", function(data) {

      let complete = ``

      data.forEach(function(card) {
        const markup = new Card(card).html()
        complete += markup
      });
      $("#user_cards").html(complete)
    });
  } else {
    let card_block = document.getElementById("user_cards");
    if (card_block.style.display === "none") {
        cardToggleButton.innerText = "Hide Cards"
        card_block.style.display = "block";
    } else {
      cardToggleButton.innerText = "View Cards"
      card_block.style.display = "none";
    }
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
      image = `<img style="float:right" src="/assets/placeholder-366d968b285bfb25d2067a60fa8805c3f685c3085c0d2288504f9b279b0f8c69.jpg">`
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
