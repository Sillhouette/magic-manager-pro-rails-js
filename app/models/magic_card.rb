require 'open-uri'
require 'mtg_sdk'
require 'erb'

class MagicCard < ApplicationRecord
  include Slugable::InstanceMethods
  extend Slugable::ClassMethods

  has_many :user_cards, dependent: :destroy
  has_many :users, through: :user_cards
  has_many :card_faces
  has_many :related_cards

  TYPES = ["Instant", "Sorcery", "Artifact", "Creature", "Enchantment", "Land", "Planeswalker"]

  SUPER_TYPES = ["Basic",  "Elite", "Host" , "Legendary", "Ongoing", "Snow", "World"]

  SUB_TYPES = ["Clue", "Contraption", "Equipment", "Fortification", "Treasure", "Vehicle",
    "Aura", "Cartouche", "Curse", "Saga", "Shrine", "Plains", "Island", "Swamp",
    "Mountain", "Forest", "Desert", "Gate", "Lair", "Locus", "Urza's", "Mine",
    "Power-Plant", "Tower", "Alara", "Arkhos", "Azgol", "Belenon", "Bolas's Meditation Realm",
    "Dominaria", "Equilor", "Ergamon", "Fabacin", "Innistrad", "Iquatana", "Ir", "Kaldheim",
    "Kamigawa", "Karsus", "Kephalai", "Kinshala", "Kolbahan", "Kyneth", "Lorwyn", "Luvion",
    "Mercadia", "Mirrodin", "Moag", "Mongseng", "Muraganda", "New Phyrexia", "Phyrexia", "Pyrulea",
    "Rabiah", "Rath", "Ravnica", "Regatha", "Segovia", "Serra's Realm", "Shadowmoor", "Shandalar",
    "Ulgrotha", "Valla", "Vryn", "Wildfire", "Xerex", "Zendikar", "Ajani", "Aminatou", "Angrath",
    "Arlinn", "Ashiok", "Bolas", "Chandra", "Dack", "Daretti", "Domri", "Dovin", "Elspeth", "Estrid",
    "Freyalise", "Garruk", "Gideon", "Huatli", "Jace", "Jaya", "Karn", "Kaya", "Kiora", "Koth",
    "Liliana", "Nahiri", "Nissa", "Narset", "Nixilis", "Ral", "Rowan", "Saheeli", "Samut", "Sarkhan",
    "Sorin", "Tamiyo", "Teferi", "Tezzeret", "Tibalt", "Ugin", "Venser", "Vivien", "Vraska", "Will",
    "Windgrace", "Xenagos", "Yanggu", "Yanling", "Arcane", "Trap"]

  CREATURE_TYPES = [ "Advisor", "Aetherborn", "Ally", "Angel", "Anteater", "Antelope", "Ape", "Archer", "Archon",
    "Artificer", "Assassin", "Assembly-Worker", "Atog", "Aurochs", "Avatar", "Badger", "Barbarian", "Basilisk",
    "Bat", "Bear", "Beast", "Beeble", "Berserker", "Bird", "Blinkmoth", "Boar", "Bringer", "Brushwagg", "Camarid",
    "Camel", "Caribou", "Carrier", "Cat", "Centaur", "Cephalid", "Chimera", "Citizen", "Cleric", "Cockatrice", "Construct",
    "Coward", "Crab", "Crocodile", "Cyclops", "Dauthi", "Demon", "Deserter", "Devil", "Dinosaur", "Djinn", "Dragon", "Drake",
    "Dreadnought", "Drone", "Druid", "Dryad", "Dwarf", "Efreet", "Elder", "Eldrazi", "Elemental", "Elephant", "Elf", "Elk", "Eye",
    "Faerie", "Ferret", "Fish", "Flagbearer", "Fox", "Frog", "Fungus", "Gargoyle", "Germ", "Giant", "Gnome", "Goat", "Goblin",
    "God", "Golem", "Gorgon", "Graveborn", "Gremlin", "Griffin", "Hag", "Harpy", "Hellion", "Hippo", "Hippogriff", "Hormarid",
    "Homunculus", "Horror", "Horse", "Hound", "Human", "Hydra", "Hyena", "Illusion", "Imp", "Incarnation", "Insect", "Jellyfish",
    "Juggernaut", "Kavu", "Kirin", "Kithkin", "Knight", "Kobold", "Kor", "Kraken", "Lamia", "Lammasu", "Leech", "Leviathan",
    "Lhurgoyf", "Licid", "Lizard", "Manticore", "Masticore", "Mercenary", "Merfolk", "Metathran", "Minion", "Minotaur", "Mole",
    "Monger", "Mongoose", "Monk", "Moonfolk", "Mutant", "Myr", "Mystic", "Naga", "Nautilus", "Nephilim", "Nightmare", "Nightstalker",
    "Ninja", "Noggle", "Nomad", "Nymph", "Octopus", "Ogre", "Ooze", "Orb", "Orc", "Orgg", "Ouphe", "Ox", "Oyster", "Pegasus", "Pentavite",
    "Pest", "Phelddagrif", "Phoenix", "Pincher", "Pirate", "Plant", "Praetor", "Prism", "Processor", "Rabbit", "Rat", "Rebel", "Reflection",
    "Rhino", "Rigger", "Rogue", "Sable", "Salamander", "Samurai", "Sand", "Saproling", "Satyr", "Scarecrow", "Scion", "Scorpion", "Scout",
    "Serf", "Serpent", "Shade", "Shaman", "Shapeshifter", "Sheep", "Siren", "Skeleton", "Slith", "Sliver", "Slug", "Snake", "Soldier",
    "Soltari", "Spawn", "Specter", "Spellshaper", "Sphinx", "Spider", "Spike", "Spirit", "Splinter", "Sponge", "Squid", "Squirrel",
    "Starfish", "Surrakar", "Survivor", "Tetravite", "Thalakos", "Thopter", "Thrull", "Treefolk", "Triskelavite", "Troll", "Turtle",
    "Unicorn", "Vampire", "Vedalken", "Viashino", "Volver", "Wall", "Warrior", "Weird", "Werewolf", "Whale", "Wizard", "Wolf", "Wolverine",
    "Wombat", "Worm", "Wraith", "Wurm", "Yeti", "Zombie", "Zubera"]

  ICONS = {
    "misc" => {
      "{CHAOS}" => "chaos"
    },
    "cost" => {
      "{T}" => "tap", "{Q}" => "untap", "{B}" => "b", "{G}" => "g", "{U}" => "u",
      "{W}" => "w", "{R}" => "r", "{C}" => "c", "{W/U}" => "wu", "{U/B}" => "ub",
      "{B/R}" => "br", "{R/G}" => "rg", "{G/W}" => "gw", "{W/B}" => "wb", "{U/R}" => "ur",
      "{B/G}" => "bg", "{R/W}" => "rw", "{G/U}" => "gu", "{2/W}" => "2w", "{2/U}" => "2u",
      "{2/B}" => "2b", "{2/R}" => "2r", "{2/G}" => "2g", "{Hb}" => "b ms-half",
      "{Hg}" => "g ms-half", "{Hu}" => "u ms-half", "{Hw}" => "w ms-half", "{Hr}" => "r ms-half",
      "{Hc}" => "c ms-half", "{X}" => "x", "{Y}" => "y", "{Z}" => "z", "{E}" => "e", "{S}" => "s",
      "{R/P}" => "rp", "{G/P}" => "gp", "{B/P}" => "bp", "{U/P}" => "up", "{W/P}" => "wp",
      "{P}" => "p", "{0}" => "0", "{1-2}" => "1-2", "{1}" => "1", "{2}" => "2", "{3}" => "3",
      "{4}" => "4", "{5}" => "5", "{6}" => "6", "{7}" => "7", "{8}" => "8", "{9}" => "9",
      "{10}" => "10", "{11}" => "11", "{12}" => "12", "{13}" => "13", "{14}" => "14", "{15}" => "15",
      "{16}" => "16", "{17}" => "17", "{18}" => "18", "{19}" => "19", "{20}" => "20", "{100}" => "100",
      "{1000000}" => "1000000"
    },
    "loyalty" => {
      "+1:" => "1", "+2:" => "2", "+3:" => "3", "+4:" => "4", "+5:" => "5", "+6:" => "6", "+7:" => "7",
      "+8:" => "8", "+9:" => "9", "+10:" => "10", "+11:" => "11", "+12:" => "12", "+13:" => "13",
      "+14:" => "14", "+15:" => "15", "+16:" => "16", "+17:" => "17", "+18:" => "18", "+19:" => "19",
      "+20:" => "20", "0:" => "0", "−1:" => "1", "−2:" => "2", "−3:" => "3", "−4:" => "4", "−5:" => "5",
      "−6:" => "6", "−7:" => "7", "−8:" => "8", "−9:" => "9", "−10:" =>"10", "−11:" => "11", "−12:" =>
      "12", "−13:" => "13", "−14:" => "14", "−15:" => "15", "−16:" => "16", "−17:" => "17", "−18:" => "18",
      "−19:" => "19", "−20:" => "20"
    }
  }

  WATERMARKS = {
    "Azorius" => "guild-azorius",
    "Boros" => "guild-boros",
    "Dimir" => "guild-dimir",
    "Golgari" => "guild-golgari",
    "Gruul" => "guild-gruul",
    "Izzet" => "guild-izzet",
    "Orzhov" => "guild-orzhov",
    "Rakdos" => "guild-rakdos",
    "Selesnya" => "guild-selesnya",
    "Simic" => "guild-simic",
    "Abzan" => "clan-abzan",
    "Jeskai" => "clan-jeskai",
    "Mardu" => "clan-mardu",
    "Sultai" => "clan-sultai",
    "Temur" => "clan-temur",
    "Atarka" => "clan-atarka",
    "Dromoka" => "clan-dromoka",
    "Kolaghan" => "clan-kolaghan",
    "Ojutai" => "clan-ojutai",
    "Silumgar" => "clan-silumgar"
  }

  def self.types
    TYPES
  end

  def self.sub_types
    SUB_TYPES
  end

  def self.super_types
    SUPER_TYPES
  end

  def self.creature_types
    CREATURE_TYPES
  end

  def self.icons
    ICONS
  end

  def self.watermark_icons
    WATERMARKS
  end

  def get_binding
    binding()
  end

  def display_attribute(attribute, title, modifier=nil)
    result = nil
    if attribute
      case(modifier)
        when 'type'
          content = scrub_type(attribute)
        when 'flavor'
          content = "<i>#{attribute}</i>"
        when 'artist'
          content = scrub_artist(attribute)
        when 'power'
          content = scrub_power(attribute)
        when 'toughness'
          content = scrub_toughness(attribute)
        when 'mana_cost'
          content = scrub_text(attribute)
        when 'watermark'
          content = get_watermark_symbol(watermark)
        when 'reserved'
          content = attribute != '' ? 'True' : 'False'
        when 'date'
          content = process_date(attribute)
        else
          content = attribute
      end

      result =
        %{
          <div class="ui item">
            <strong>#{title}: #{content}</strong>
          </div>
        }
      ERB.new(result).result(binding)
    end
    result
  end

  def display_text_attribute(attribute, title)
    result = ""

    content = scrub_text(attribute)

    result =
      %{
        <div class="ui item">
          <div class="ui small header">
            <strong>#{title}:</strong>
          </div>
          <ol class="ui list">
            <strong>#{content.split("\n").map{ |line| "<li value=''>" + line + "</li>"}.join()} </strong>
          </ol>
        </div>
      }
    if attribute != [] && attribute != nil && attribute != ''
      ERB.new(result).result(binding)
    else
      nil
    end
  end

  def display_array_attribute(attribute, title, modifier=nil)
    attribute = attribute.compact.join(', ')
    result = ""

    case(modifier)
      when 'type'
        content = scrub_type(attribute)

      else
        content = attribute
    end

    result =
      %{
        <div class="ui item">
          <strong>#{title}: #{content}</strong>
        </div>
      }
    if attribute != [] && attribute != nil && attribute != ''
      ERB.new(result).result(binding)
    else
      nil
    end
  end

  def display_listed_attribute(attribute, title, modifier)
    result = ""

    case(modifier)
      when 'legalities'
        content = attribute.collect { |format, legality| "<li class='margin' value='*'>#{format.titlecase}: #{legality == 'legal' ? 'Legal' : 'Banned'}</li>"}.join
      when 'rulings'
        content = attribute.collect { |ruling_object| "<li class='margin' value='*'>#{process_date(ruling_object["date"])}: #{ruling_object["text"]}</li>"}.flatten.join
      when 'text'
        content = scrub_text(attribute).split("\n").map{ |line| "<li value=''>" + line + "</li>"}.join
      when 'images'
        content = attribute.collect { |title, url| "<li class='margin' value='*'>#{title.gsub('_', " ").titlecase}: <a href=#{url}>#{url}</a></li>"}.flatten.join
      when 'ids'
        content = attribute.collect { |id_type, id| "<li class='margin' value='*'>#{id_type}: #{id}</li>"}.join
      else
        content = attribute
    end

    result =
      %{
        <div class="ui item">
          <details>
            <summary>
              <strong>#{title}:</strong>
            </summary>
            <ul>
              <strong>
                #{content}
              </strong>
            </ul>
          </details>
        </div>
      }
    if attribute != [] && attribute != nil && attribute != ''
      ERB.new(result).result(binding)
    else
      nil
    end
  end

  def display_card_faces
    result = %{
    }
    self.card_faces.each_with_index do |card_face, index|
      result << "<div class='card_face_#{index + 1}'>"
      result << "<h3 class='ui header'>"
      result << "Card Face #{index + 1}:"
      result << "</h3>"
      result << self.display_attribute(card_face.artist.titlecase, "Artist", 'artist')
      result << "</div>"
      result << "<br/>"
    end
    result
  end

#   artist
# color_indicator
# colors
# flavor_text
# illustration_id
# image_uris
# loyalty
# mana_cost
# name
# object
# oracle_text
# power
# printed_name
# printed_text
# printed_type_line
# toughness
# type_line
# magic_card_id
# watermark

  def scrub_colors(attribute_type)
    case(attribute_type)
      when 'color_indicator'
        colors_string = self.color_indicator.join(', ')
      when 'color_identity'
        colors_string = self.color_identity.join(', ')
      when 'colors'
        colors_string = self.colors.join(', ')
    end
    color_conversion_chart = {'B' => 'Black', 'G' => 'Green', 'U' => 'Blue', 'W' => 'White', 'R' => 'Red'}
    color_conversion_chart.each do |symbol, color|
      colors_string = colors_string.gsub(symbol, color) if colors.include?(symbol)
    end
    colors_string.split(', ')
  end

  def compile_ids
    id_list = {}
    id_list['MTG Arena'] = self.arena_id if self.arena_id
    id_list['Scryfall'] = self.scryfall_id if self.scryfall_id
    id_list['MTG Online'] = self.mtgo_id if self.mtgo_id
    id_list['MTG Online foil'] = self.mtgo_foil_id if self.mtgo_foil_id
    id_list['Multiverse Id(s)'] = self.multiverse_ids.join(', ') if self.multiverse_ids
    id_list['TCG Player'] = self.tcgplayer_id if self.tcgplayer_id
    id_list['Oracle'] = self.oracle_id if self.oracle_id
    id_list
  end

  def process_date(date)
    date_object = Date.strptime(date, "%Y-%m-%e")
    updated_date = date_object.strftime("%B %e, %Y")
    content = updated_date.to_s
  end

  def process_cmc
    proper_format = self.cmc % 1 == 0 ? convert_to_fraction(self.cmc.to_i.to_s) : convert_to_fraction(self.cmc.to_s.gsub("0.", '.'))
  end

  def convert_to_fraction(stringified_float)
    stringified_float.gsub('.5', "&#189;")
  end

  def parse_type_line(type_line)
    self.subtypes = self.subtypes == [] ? (self.class.sub_types + self.class.creature_types).map { |subtype|
                    type_line.include?(subtype) ? subtype : nil } : self.subtypes
    self.supertypes = self.supertypes == [] ? self.class.super_types.map { |supertype|
                    type_line.include?(supertype) ? supertype : nil } : self.supertypes
    self.types = self.types == [] ? self.class.types.map { |type|
                    type_line.include?(type) ? type : nil } : self.types
  end

  def get_rarity_statement(rarity)
    rarity_statement = ""
    if(rarity == "Special")
      rarity_statement = '<strong class="ss-mythic">' + rarity.titlecase + '</strong>'
    else
      rarity_statement = '<strong class="ss-' + rarity.downcase + '">' + rarity.titlecase + '</strong>'
    end
    rarity_statement
  end

  def scrub_text(text)
    self.class.icons.each do |icon_class, class_set|
      case(icon_class)
      when 'cost'
        class_set.each do |symbol, class_name|
          text = text.gsub(symbol, "<i class='ms ms-#{class_name} ms-cost ms-shadow'></i> ")
        end
      when 'loyalty'
        class_set.each do |symbol, class_name|
          case (symbol[0])
          when '+'
            text = text.gsub(symbol, "<i class='ms ms-loyalty-up ms-loyalty-#{class_name}'></i>: ")
          when '−'
            text = text.gsub(symbol, "<i class='ms ms-loyalty-down ms-loyalty-#{class_name}'></i>: ")
          when '0'
            text = text.gsub(symbol, "<i class='ms ms-loyalty-zero ms-loyalty-0'></i>: ")
          end
        end
      when 'misc'
        class_set.each do |symbol, class_name|
          text = text.gsub(symbol,  "<i class='ms ms-#{class_name}'></i> ")
        end
      end
    end
    text
  end

  def scrub_power(power)
    string = "<i class='ms ms-power'></i> " + convert_to_fraction(power.to_s)
  end

  def scrub_toughness(toughness)
    string = "<i class='ms ms-toughness'></i> " + convert_to_fraction(toughness.to_s)
  end

  def scrub_artist(artist)
    string = "<i class='ms ms-artist-nib'></i> " + artist
  end

  def get_set_icon(set_code)
    set_code = set_code == "TSB" ? "TSP" : set_code
    set_code = set_code == "CEI" ? "XICE" : set_code
    set_code = set_code == "CED" ? "XCLE" : set_code
    '<i class="ss ss-' + set_code.downcase + '"></i> '
  end

  def get_watermark_symbol(watermark)
    icon_css = watermark.titlecase

    self.class.watermark_icons.each do |name, icon_code|
      icon_css = icon_css.gsub(name, "<i class='ms ms-#{icon_code}'></i> #{name}")
    end
    icon_css
  end

  def scrub_type(type_line)
    self.class.types.each do |type|
      type_line = type_line.gsub(type, "<i class='ms ms-#{type.downcase}'></i> #{type}") if type_line.include?(type)
    end
    type_line
  end

  def safe_open(url)
    if url.blank?
      safe_open = "#{Rails.root}/app/assets/images/placeholder.jpg"
    else
      open(url)
    end
  rescue OpenURI::HTTPError => e
    if e.message == '404 Not Found'
      safe_open = "#{Rails.root}/app/assets/images/placeholder.jpg"
    end
  end

  def get_price
    page = safe_open("https://api.scryfall.com/cards/multiverse/#{self.multiverse_ids.first}")

    if page.class == StringIO
      page = page.string()
      hash = JSON.parse(page)
      price = hash['prices']['usd'] ? ("$" + hash['prices']['usd']) : 'Unknown'
    else
      price = 'Unknown'
    end

    return price
  end

  def self.fetch_new_scryfall_data
    bulk_data = open("https://api.scryfall.com/bulk-data").read()
    bulk_data_hash = JSON.parse(bulk_data)
    default_cards_data = bulk_data_hash['data'][1]
    default_cards_url = default_cards_data['permalink_uri']
    default_cards_data = File.read(open(default_cards_url))
    cards = JSON.parse(default_cards_data)
    # File.open("public/bulk_data/scryfall-default-cards.json", "w") do |f|
    #     f.write(default_cards_data)
    # end
  end

  def self.fetch_new_mtgjson_data
    all_cards_data = File.read(open("https://mtgjson.com/json/AllCards.json"))
    cards = JSON.parse(all_cards_data)
    #cards = JSON.parse(all_cards_data)
    # File.open("public/bulk_data/bulk_data/AllCards.json", "w") do |f|
    #     f.write(all_cards_data)
    # end
  end

  def self.fetch_new_bulk_data
    [ self.fetch_new_scryfall_data, self.fetch_new_mtgjson_data ]
  end

  # def self.read_file(data_file)
  #   file = File.read(data_file)
  #   $additional_card_data = JSON.parse(file)
  # end

  def self.load_database
    fetch_cards(self.fetch_new_bulk_data)
  end

  def self.fetch_cards(data_array)
    #binding.pry
    #file = File.read(data_array[0])
    #cards = JSON.parse(file)
    full_cards = []

    data_array[0].each_with_index do |card, index|
      unless self.find_by(scryfall_id: card["id"])
        card_info = {}
        card_info["arena_id"] = card["arena_id"] if card["arena_id"]
        card_info["scryfall_id"] = card["id"] if card["id"]
        card_info["lang"] = card["lang"] if card["lang"]
        card_info["mtgo_id"] = card["mtgo_id"] if card["mtgo_id"]
        card_info["mtgo_foil_id"] = card["mtgo_foil_id"] if card["mtgo_foil_id"]
        card_info["multiverse_ids"] = card["multiverse_ids"] if card["multiverse_ids"]
        card_info["tcgplayer_id"] = card["tcgplayer_id"] if card["tcgplayer_id"]
        card_info["object"] = card["object"] if card["object"]
        card_info["oracle_id"] = card["oracle_id"] if card["oracle_id"]
        card_info["prints_search_uri"] = card["prints_search_uri"] if card["prints_search_uri"]
        card_info["rulings_uri"] = card["rulings_uri"] if card["rulings_uri"]
        card_info["scryfall_uri"] = card["scryfall_uri"] if card["scryfall_uri"]
        card_info["uri"] = card["uri"] if card["uri"]
        card_info["cmc"] = card["cmc"] if card["cmc"]
        card_info["colors"] = card["colors"] if card["colors"]
        card_info["color_identity"] = card["color_identity"] if card["color_identity"]
        card_info["color_indicator"] = card["color_indicator"] if card["color_indicator"]
        card_info["edhrec_rank"] = card["edhrec_rank"] if card["edhrec_rank"]
        card_info["foil"] = card["foil"] if card["foil"]
        card_info["hand_modifier"] = card["hand_modifier"] if card["hand_modifier"]
        card_info["layout"] = card["layout"] if card["layout"]
        card_info["legalities"] = card["legalities"] if card["legalities"]
        card_info["life_modifier"] = card["life_modifier"] if card["life_modifier"]
        card_info["loyalty"] = card["loyalty"] if card["loyalty"]
        card_info["mana_cost"] = card["mana_cost"] if card["mana_cost"]
        card_info["name"] = card["name"] if card["name"]
        card_info["nonfoil"] = card["nonfoil"] if card["nonfoil"]
        card_info["oracle_text"] = card["oracle_text"] if card["oracle_text"]
        card_info["oversized"] = card["oversized"] if card["oversized"]
        card_info["power"] = card["power"] if card["power"]
        card_info["reserved"] = card["reserved"] if card["reserved"]
        card_info["toughness"] = card["toughness"] if card["toughness"]
        card_info["type_line"] = card["type_line"] if card["type_line"]
        card_info["artist"] = card["artist"] if card["artist"]
        card_info["border_color"] = card["border_color"] if card["border_color"]
        card_info["collector_number"] = card["collector_number"] if card["collector_number"]
        card_info["digital"] = card["digital"] if card["digital"]
        card_info["flavor_text"] = card["flavor_text"] if card["flavor_text"]
        card_info["frame"] = card["frame"] if card["frame"]
        card_info["frame_effect"] = card["frame_effect"] if card["frame_effect"]
        card_info["full_art"] = card["full_art"] if card["full_art"]
        card_info["games"] = card["games"] if card["games"]
        card_info["hires_image"] = card["hires_image"] if card["hires_image"]
        card_info["illustration_id"] = card["illustration_id"] if card["illustration_id"]
        card_info["image_uris"] = card["image_uris"] if card["image_uris"]
        card_info["printed_name"] = card["printed_name"] if card["printed_name"]
        card_info["printed_text"] = card["printed_text"] if card["printed_text"]
        card_info["printed_type_line"] = card["printed_type_line"] if card["printed_type_line"]
        card_info["promo"] = card["promo"] if card["promo"]
        card_info["purchase_uris"] = card["purchase_uris"] if card["purchase_uris"]
        card_info["rarity"] = card["rarity"] if card["rarity"]
        card_info["related_uris"] = card["related_uris"] if card["related_uris"]
        card_info["released_at"] = card["released_at"] if card["released_at"]
        card_info["reprint"] = card["reprint"] if card["reprint"]
        card_info["scryfall_set_uri"] = card["scryfall_set_uri"] if card["scryfall_set_uri"]
        card_info["set"] = card["set"] if card["set"]
        card_info["set_name"] = card["set_name"] if card["set_name"]
        card_info["set_search_uri"] = card["set_search_uri"] if card["set_search_uri"]
        card_info["set_uri"] = card["set_uri"] if card["set_uri"]
        card_info["story_spotlight"] = card["story_spotlight"] if card["story_spotlight"]
        card_info["watermark"] = card["watermark"] if card["watermark"]

        all_parts_data = card["all_parts"] if card["all_parts"]
        card_faces_data = card["card_faces"] if card["card_faces"]

        additional_attributes = self.fetch_additional_data(card_info["scryfall_id"], data_array[1])
        full_card = card_info.merge(additional_attributes)

        if !self.find_by("scryfall_id": full_card['scryfall_id'])
          card_object = self.create(full_card)
          if card_faces_data
            card_faces_data.each do |card_face|
              card_object.card_faces.create(card_face)
            end
            card_faces_data = nil
          end
          if all_parts_data
            all_parts_data.each do |related_card|
              card['scryfall_id'] = related_card.delete('id')
              card_object.related_cards.create(related_card)
            end
            all_parts_data = nil
          end
        end
        print("#{index} cards created so far.")
      end
    end
    puts "Finished creating cards"
    $additional_card_data = nil
  end

  def self.fetch_additional_data(scryfall_id, data_file)
    if !$additional_card_data
      $additional_card_data = data_file
    end

    card_info = {}

    $additional_card_data.each_with_index do |(card_name, card_attributes), index|
      if card_attributes["scryfallId"] == scryfall_id
        card_info["supertypes"] = card_attributes["supertypes"] if card_attributes["supertypes"] #array
        card_info["types"] = card_attributes["types"] if card_attributes["types"] #array
        card_info["subtypes"] = card_attributes["subtypes"] if card_attributes["subtypes"] #array
        card_info["other_names"] = card_attributes["names"] if card_attributes["names"] #array
        card_info["variations"] = card_attributes["variations"] if card_attributes["variations"] #array
        card_info["original_text"] = card_attributes["original_text"] if card_attributes["original_text"] #string
        card_info["original_type"] = card_attributes["original_type"] if card_attributes["original_type"] #string
        card_info["rulings"] = card_attributes["rulings"] if card_attributes["rulings"]# => array of ruling objects
        card_info["multiverse_id"] = card_attributes["multiverseid"] if card_attributes["multiverseid"]
      end
    end
    card_info
  end

end
