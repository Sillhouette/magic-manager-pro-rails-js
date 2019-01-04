function getDecks() {
  let deckToggleButton = document.getElementById("toggle_decks");
  if ($("#user_decks").html() === "") {
    deckToggleButton.innerText = "Hide Decks";
    let id = deckToggleButton.dataset.id;

    $.get(
      "/users/" + id + "/decks",
      function(data) {
        let decksMarkup = ``;

        data.forEach(function(deck) {
          let currentDeck = new Deck(deck);
          const currentDeckMarkup = currentDeck.html();

          decksMarkup += currentDeckMarkup;
        });
        $("#user_decks").html(decksMarkup);
        alphabetizeDeckEventListener();
      },
      "json"
    );
  } else {
    let deck_block = document.getElementById("user_decks");
    if (deck_block.style.display === "none") {
      deckToggleButton.innerText = "Hide Decks";
      deck_block.style.display = "block";
    } else {
      deckToggleButton.innerText = "View Decks";
      deck_block.style.display = "none";
    }
  }
}

const Deck = (function() {
  const allDecks = [];

  return class {
    constructor(deck) {
      this.id = deck.id;
      this.name = deck.name;
      this.userId = deck.user_id;
      this.format = deck.format;
      this.numCards = deck.deck_cards.length;

      this.cards = deck.deck_cards.map(function(card) {
        return new DeckCard(card);
      });

      allDecks.push(this);
    }

    static all() {
      return allDecks;
    }

    deckCards() {
      let deckCardsMarkup = ``;

      this.cards.forEach(function(card) {
        deckCardsMarkup += card.html();
      });

      return deckCardsMarkup;
    }

    alphabetizeDeckCards() {
      let sorted = this.cards.sort(function(a, b) {
        let nameA = a.name.toUpperCase();
        let nameB = b.name.toUpperCase();
        if (nameA < nameB) {
          return -1;
        }
        if (nameA > nameB) {
          return 1;
        }
        return 0;
      });

      let alphabetizedDeckCardsMarkup = ``;

      sorted.forEach(function(card) {
        alphabetizedDeckCardsMarkup += card.html();
      });
      return alphabetizedDeckCardsMarkup;
    }

    html() {
      let result = `
         <div id='deck_${this.id}'>
          <fieldset>
            <legend>

            <h3> ${this.name}

            <button class="ui circular tiny button teal" type="button" id="deck_${
              this.id
            }_toggle" onclick="toggleDeckDetails(${
        this.id
      })" >View Details</button>

            <form method='Update' action='/users/${this.userId}/decks/${
        this.id
      }/edit' form={ style="display:inline-block"}>
               <input class="ui circular tiny button teal" value='Edit' type='submit' />
            </form>

            <form method='post' action='/users/${this.userId}/decks/${
        this.id
      }' data-remote='true' form={ style="display:inline-block"}>
               <input name='_method' value='delete' type='hidden' />
               <input class="ui circular tiny button teal" value='Delete' type='submit' />
            </form>

            </h3></legend>

            <div class="ui blue compact mini message">
              <strong>Format: </strong>${this.format}
            </div>

            <br/>

            <div class="ui blue compact mini message">
              <strong>Cards: </strong>${this.numCards}
            </div>

            <div id='deck_${this.id}_cards' style="display:none">
              <button class="alphabetizeButtons ui circular tiny button teal" type="button" id=${
                this.id
              }>Alphabetize</button>

              <div id='deck_${this.id}_cards_container'>
                ${this.deckCards()}
              </div>
            </div>

          </fieldset>
        </div>`;
      return result;
    }
  };
})();

function alphabetizeDeckEventListener() {
  $(".alphabetizeButtons").on("click", event => {
    event.preventDefault();

    let currentDeck = Deck.all().find(function(deck) {
      return deck.id === parseInt(event.target.id);
    });

    let alphabetizedCardsMarkup = currentDeck.alphabetizeDeckCards();

    $("#deck_" + currentDeck.id + "_cards_container").html(
      alphabetizedCardsMarkup
    );
  });
}

function toggleDeckDetails(deck_id) {
  let detailsToggleButton = document.getElementById(
    "deck_" + deck_id + "_toggle"
  );
  let deck_block = document.getElementById("deck_" + deck_id + "_cards");
  if (deck_block.style.display === "none") {
    detailsToggleButton.innerText = "Hide Details";
    deck_block.style.display = "block";
  } else {
    detailsToggleButton.innerText = "View Details";
    deck_block.style.display = "none";
  }
}

class DeckCard {
  constructor(card) {
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
    let image = `<img src="${
      this.image_url
    }" class="ui right floated image card-image"`;
    if (!this.image_url) {
      image = `<img class="ui right floated image card-image" src="/assets/placeholder-366d968b285bfb25d2067a60fa8805c3f685c3085c0d2288504f9b279b0f8c69.jpg">`;
    }

    let main_board_quantity = this.main_board_quantity
      ? this.main_board_quantity
      : "0";
    let side_board_quantity = this.side_board_quantity
      ? this.side_board_quantity
      : "0";
    let main_board_option = this.main_board_option ? `checked` : null;
    let side_board_option = this.side_board_option ? `checked` : null;

    let deckCardMarkup = ``;

    deckCardMarkup += `
      <div id="deck_${this.deck_id}_card_${this.id}">
        <fieldset>
          <legend><h3> ${this.name}</h3></legend>

          <br/>

          ${image}

          </br>

          <div class="ui blue compact mini message">
            <strong>Main Board: </strong>${main_board_quantity}
          </div>

          <br/><br/>

          <div class="ui blue compact mini message">
            <strong>Side Board: </strong>${side_board_quantity}
          </div>

          <br/><br/>

          <div class="ui disabled toggle checkbox">
            <input type="checkbox" disabled="disabled" ${main_board_option}>
            <label>Main Board Option:</label>
          </div>

          <br/><br/><br/>

          <div class="ui disabled toggle checkbox">
            <input type="checkbox" disabled="disabled" ${side_board_option}>
            <label>Side Board Option:</label>
          </div>
        </fieldset>
      </div>
    `;
    return deckCardMarkup;
  }
}
