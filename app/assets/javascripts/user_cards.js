function getCards() {
  let cardToggleButton = document.getElementById("toggle_cards");
  if ($("#user_cards").html() === "") {
    cardToggleButton.innerText = "Hide Cards";
    let id = $(this).data("id");

    $.get("/users/" + id + "/user_cards.json", function(data) {
      let complete = ``;

      data.forEach(function(card) {
        const markup = new Card(card).html();
        complete += markup;
      });
      $("#user_cards").html(complete);
    });
  } else {
    let card_block = document.getElementById("user_cards");
    if (card_block.style.display === "none") {
      cardToggleButton.innerText = "Hide Cards";
      card_block.style.display = "block";
    } else {
      cardToggleButton.innerText = "View Cards";
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
    let image = `<img src="${
      this.image_url
    }" class="ui right floated image card-image"`;
    if (!this.image_url) {
      image = `<img class="ui right floated image card-image" src="/assets/placeholder-366d968b285bfb25d2067a60fa8805c3f685c3085c0d2288504f9b279b0f8c69.jpg">`;
    }

    let result = `
      <div id='card_${this.id}'>
        <fieldset>
          <legend><h3> ${this.name}

          <form method='Get' action='/magic_cards/${
            this.magic_card_id
          }' form={ style="display:inline-block"}>
             <input class="ui circular tiny button teal" value='View Details' type='submit' />
           </form>

          <form method='Update' action='/user_cards/${
            this.id
          }/edit' form={ style="display:inline-block"}>
             <input class="ui circular tiny button teal" value='Edit' type='submit' />
           </form>

          <form method='post' action='/user_cards/${
            this.id
          }' data-remote='true' form={ style="display:inline-block"}>
             <input name='_method' value='delete' type='hidden' />
             <input class="ui circular tiny button teal" value='Delete' type='submit' />
           </form>
          </h3></legend>

          ${image}

          <br/><br/>

          <div class="ui teal compact message">
            <strong>Quantity: </strong>${this.quantity}
          </div>

          </br><br/>

          <div class="ui teal compact message">
            <strong>Value(s): </strong>${this.value}
          </div>

          </br><br/>

          <div class="ui teal compact message">
            <strong>Quality: </strong>${this.quality}
          </div>
        </fieldset>
      </div>`;
    return result;
  }
}
