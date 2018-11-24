Project Requirements
1. Must render at least one index page (index resource - 'list of things') via JavaScript and an Active Model Serialization JSON Backend.
  For example: in a blog domain with users and posts, you might display the index of the user's posts on the users show page, fetching the posts via a AJAX GET request, with the backend rendering the posts in JSON format, and then appending the posts to the page.
    Dynamically display my decks and cards using the pre-existing buttons on the user's show page.

2. Must render at least one show page (show resource - 'one specific thing') via JavaScript and an Active Model Serialization JSON Backend.
  Borrowing from the previous blog domain example, you might allow a user to sift through the posts by clicking a 'Next' button on the posts show page, with the next post being fetched via AJAX and rendered through JavaScript.
    Dynamically display user decks from the prexisting show details button with JS on the user's decks page, ability to hide details as well.

3. Your Rails application must dynamically render on the page at least one 'has-many' relationship through JSON using JavaScript.
  In the previous blog domain example, if each of the posts has many comments, you could render those comments as well on that post's show page.
    Previous solution, done correctly would fulfill this requirement

4. Must use your Rails application and JavaScript to render a form for creating a resource that submits dynamically.
  In the blog domain example, a user might be able to add a comment to a post, and the comment would be serialized, and submitted via an AJAX POST request, with the response being the new object in JSON and then appending that new comment to the DOM using JavaScript (ES6 Template Literals can help out a lot with this).
    Add user cards dynamically through the user's usercards index page using a form.

5. Must translate the JSON responses into JavaScript Model Objects using either ES6 class or constructor syntax. The Model Objects must have at least one method on the prototype. Formatters work really well for this.
  Borrowing from the blog domain example, instead of plainly taking the JSON response of the newly created comment and appending it to the DOM, you would create a Comment prototype object and add a function to that prototype to perhaps concatenate (format) the comments authors first and last name. You would then use the object to append the comment information to the DOM.
    Handle json responses by creating JS objects and making a prototype method "display" to append the objects to the current page.





    <script type="text/javascript" charset="utf-8">
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

            <legend><h3> <%=@user.name.titlecase%>'s Decks:</h3></legend>

            <%= form_tag("/users/${id}/decks/new", method: "get") do %>

              <%=submit_tag("Add New Deck") %>

              <%= label_tag(:format, "Format:") %>
              <%= select_tag(:format, options_for_select(Deck.formats), :prompt => "Select a Format")%>

              <button type="button" onclick="hideDecks()" style="float:right;display:inline">Hide Decks</button>
            <% end %>
            `

            data.forEach(function(deck) {
              const markup = `
              <div id='deck_${deck.id}'>
                <fieldset>
                  <legend><h4> ${deck.name}

                  <button class="js-deck-details" data-user_id="<%= @user.id %>" data-deck_id="${deck.id}">View Details</button>

                  <%=button_to "Edit", "/users/${deck.user_id}/decks/${deck.id}/", method: "get", form: { style: "display:inline-block"} %>

                  <form method='post' action='/users/${deck.user_id}/decks/${deck.id}' data-remote='true' form={ style="display:inline-block"}>
                     <input name='_method' value='delete' type='hidden' />
                     <input value='Delete' type='submit' />
                   </form>
                  </h4></legend>

                  <p>
                    <%= "Format: ${deck.format}" %> <br/>
                    <%= "Cards: ${deck.deck_cards.length}" %>
                  </p>
                </fieldset>
              </div>
              `
              complete += markup
            });
            complete += `</fieldset>`
            $("#user_decks").html(complete)
          });
        });
      });
    </script>

    <script type="text/javascript" charset="utf-8">
      $(function() {
        $("#user_decks").on("click", ".js-deck-details", function() {
          var user_id = $(this).data("user_id");
          var deck_id = $(this).data("deck_id");
          $.get("/users/" + user_id + "/decks/" + deck_id + ".json" , function(data) {

            var complete = ``

            data.deck_cards.forEach(function(card) {
              var user_card_id = ${card.user_card_id}

              const markup = `
              <fieldset>
                <legend><h3><%=MagicCard.find_by(id: UserCard.find(${user_card_id}).magic_card_id).name %></h3></legend>
                <% if MagicCard.find_by(id: UserCard.find(${card.user_card_id}).magic_card_id).image_url %>
                  <img src=<%='MagicCard.find_by(id: UserCard.find("${card.user_card_id}").magic_card_id).image_url'%>, style="float:right">
                <% else %>
                  <%= 'image_tag("placeholder.jpg", style: "float:right" )'%>
                <% end %>
                <%= "Main Board: ${card.main_board_quantity} ? ${card.main_board_quantity} : 0}" %><br/><br/><br/><br/>
                <%= "Side Board: ${card.side_board_quantity} ? ${card.side_board_quantity} : 0}" %><br/><br/><br/><br/>
                <%= "Main Board Option: ${ card.main_board_option} ? ${card.main_board_option} : 'False'}" %><br/><br/><br/><br/>
                <%= "Side Board Option: ${ card.side_board_option} ? ${card.side_board_option} : 'False'}" %><br/><br/><br/><br/>
              </fieldset>
              `
              complete += markup
            });
            $("#deck_" + deck_id).html(complete)
          });
        });
      });
    </script>

    <script>
      function hideDecks() {
        var x = document.getElementById("user_decks");
        if (x.style.display === "none") {
            x.style.display = "block";
        } else {
            x.style.display = "none";
        }
      }
    </script>

    <script type="text/javascript" charset="utf-8">
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

            <legend><h3> <%=@user.name.titlecase%>'s Cards:</h3></legend>

            <button type="button" onclick="hideCards()" style="float:right;display:inline">Hide Cards</button>

            <fieldset>

            <legend><h4>Add a new card:</h4></legend>

            <%= render partial: "/user_cards/user_card_form", locals: {editing: false}%>

            </fieldset>

            `

            data.forEach(function(card) {
              const markup = `
              <div id='card_${card.id}'>
                <fieldset>
                  <legend><h4> ${card.magic_card_name}

                  <%= button_to "View Details", "/magic_cards/${card.magic_card_id}/", method: "get", form: { style: "display:inline-block"} %>

                  <%=button_to "Edit", "/user_cards/${card.id}/edit", method: "get", form: { style: "display:inline-block"} %>

                  <form method='post' action='/user_cards/${card.id}' data-remote='true' form={ style="display:inline-block"}>
                     <input name='_method' value='delete' type='hidden' />
                     <input value='Delete' type='submit' />
                   </form>
                  </h4></legend>

                  <% if "${card.magic_card.image_url}" %>
                    <img src="<%='${card.magic_card.image_url}'%>", style="float:right">
                  <% else %>
                    <%= image_tag("placeholder.jpg", style: "float:right" )%>
                  <% end %>

                  <p>
                    <%= "Quantity: ${card.quantity}" %>

                    </br></br>

                    <%= "Value(s): ${card.value}" %>

                    </br></br>

                    <%= "Quality: ${card.quality}" %>
                  </p>
                </fieldset>
              </div>
              `
              complete += markup
            });
            complete += `</fieldset>`
            $("#user_cards").html(complete)
          });
        });
      });
    </script>

    <script>
      function hideCards() {
        var x = document.getElementById("user_cards");
        if (x.style.display === "none") {
            x.style.display = "block";
        } else {
            x.style.display = "none";
        }
      }
    </script>
