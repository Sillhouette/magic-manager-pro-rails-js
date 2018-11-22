
$(function() {
  $(".js-view-decks").on("click", function() {
    var x = document.getElementById("user_decks");
    if (x.style.display === "none") {
        x.style.display = "block";
    }
    var id = $(this).data("id");

    $.get("/users/" + id + "/decks.json", function(data) {

      var complete = `
      <fieldset>

      <legend><h3> ${data[0].user.name}'s Decks:</h3></legend>
      <button type="button" onclick="hideDecks()" >Hide Decks</button>

      `
      // <%= form_tag("/users/${id}/decks/new", method: "get") do %>
      //
      //   <%=submit_tag("Add New Deck") %>
      //
      //   <%= label_tag(:format, "Format:") %>
      //   <%= select_tag(:format, options_for_select(Deck.formats), :prompt => "Select a Format")%>
      // <% end %>

      data.forEach(function(deck) {
        const markup = new Deck(deck).html()
        complete += markup
      });
      complete += `</fieldset>`
      $("#user_decks").html(complete)
    });
  });
});

function hideDecks() {
  var x = document.getElementById("user_decks");
  if (x.style.display === "none") {
      x.style.display = "block";
  } else {
      x.style.display = "none";
  }
}

class Deck {
  constructor(deck) {
    this.id = deck.id;
    this.name = deck.name;
    this.user_id = deck.user_id;
    this.format = deck.format;
    this.num_cards = deck.deck_cards.length;

    this.cards = deck.deck_cards.map(function(card){
      return new DeckCard(card);
    });
  }

  deckCards(){

      let html = ``

      this.cards.forEach(function(card) {
        html += card.html()
      });

      return html;
  }

  html() {

    let result = `
       <div id='deck_` + this.id + `'>
        <fieldset>
          <legend><h4> ` + this.name + `

          <button type="button" onclick="toggleDeckDetails(`+ this.id +`)" >Toggle Details</button>

          <form method='Update' action='/users/` + this.user_id + `/decks/` + this.id + `/edit' form={ style="display:inline-block"}>
             <input value='Edit' type='submit' />
           </form>


          <form method='post' action='/users/` + this.user_id + `/decks/` + this.id + `' data-remote='true' form={ style="display:inline-block"}>
             <input name='_method' value='delete' type='hidden' />
             <input value='Delete' type='submit' />
           </form>
          </h4></legend>

          <p>
            Format: ` + this.format + `<br/>
            Cards: ` + this.num_cards + `
          </p>

          <div id='deck_` + this.id + `_cards' style="display:none">` + this.deckCards() + `</div>
        </fieldset>
      </div>
    `
    return result
  }
}

function toggleDeckDetails(deck_id){
  var x = document.getElementById("deck_" + deck_id + "_cards");
    if (x.style.display === "none") {
        x.style.display = "block";
    } else {
        x.style.display = "none";
    }
}

class DeckCard {
  constructor(card){

    this.id = card.id;
    this.deck_id = card.deck_id;
    this.name = card.user_card.magic_card_name;
    this.main_board_quantity = card.main_board_quantity;
    this.side_board_quantity = card.side_board_quantity;
    this.main_board_option = card.main_board_option;
    this.side_board_option = card.side_board_option;
    this.image_url = card.user_card.magic_card.image_url;
    this.card_url = "/magic_cards/" + card.user_card.magic_card.id;
  }

  html() {
    let image = `<img src="` + this.image_url + `" style="float:right"`
    if (!this.image_url){
      image = `<img src="placeholder.jpg" style="float:right"`
    }

    let main_board_quantity = this.main_board_quantity ? this.main_board_quantity : "0";
    let side_board_quantity = this.side_board_quantity ? this.side_board_quantity : "0";
    let main_board_option = this.main_board_option ? "True" : "False";
    let side_board_option = this.side_board_option ? "True" : "False";

    let html = ``
     html += `
    <div id="deck_` + this.deck_id + `_card_` + this.id + `">
       <fieldset>
         <legend><h3> ` + this.name + `</h3></legend>

         ` + image + `</br>

         Main Board: ` + main_board_quantity + `<br/><br/><br/><br/>
         Side Board: ` + side_board_quantity + `<br/><br/><br/><br/>
         Main Board Option: ` + main_board_option + ` <br/><br/><br/><br/>
         Side Board Option: ` + side_board_option + ` <br/><br/><br/><br/>
       </fieldset>
      </div>
    `
    return html
  }
}
