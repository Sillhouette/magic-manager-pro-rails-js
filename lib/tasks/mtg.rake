namespace :mtg do
  desc "Imports all of the MTG cards from the MTG api"
  task import_magic_cards: :environment do
    MagicCard.load_database
  end

end
