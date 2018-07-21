We have many users

Users can:

create an account
Log in
Log out

edit username
edit dci_number
delete account (with warning)

Create own cards
view index of all owned cards
view own cards
edit own cards from view page
delete own cards from view page

Create own decks
view index of own decks(lists)
view own decks(lists)
edit own decks from view page(lists)
delete own decks from view page

Deck lists need:
edit - to edit card quantities
new - to add card quantities

Cards have:
name (required)
mana cost
value
quantity
quality
foil
color(s)
super_types
types
rarity
set

Decks have:

name (required)
Format (required)

Deck Creation:
feature: All user's cards are listed for the user to choose one for his deck
feature: choosing a format filters out illegal cards for that format

Create a card: (nested form)
list all card attributes
creating a card adds it to the list above

Submitting a deck creation takes you to edit deck_list page:

deck_list:
handles card quantities quantities are max of 4, unless owner has less then four or it is restricted, then it's 1
looks like this: Card_name Field-for-main-board-quantity field-for-sideboard-quantity

basic lands and quantities are located on this page: island, swamp, plains, forest, mountain

totals all mainboard cards (min 60)
totals all sideboard options (max 15)










Set
has many magic_cards

magic_card
belongs to set
has_many user_cards
has_many users through user_cards

user_cards
belongs to user
belongs to magic_card
has_many deck_cards
user_id
magic_card_id

users
has many user_cards
has many magic_cards through user_cards
has many decks

deck
belongs to user
has_many deck_cards
has_many user_cards through deck_cards
has many cards through user_cards

deck_cards
belong_to deck
belongs to user_cards
