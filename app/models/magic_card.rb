require 'open-uri'
class MagicCard < ApplicationRecord
  include Slugable::InstanceMethods
  extend Slugable::ClassMethods

  has_many :user_cards, dependent: :destroy
  has_many :users, through: :user_cards

  TYPES = ["Instant", "Sorcery", "Artifact", "Creature", "Enchantment", "Land", "Planeswalker"]

  def self.types
    TYPES
  end
  
  def self.parse_json
    page_number = 1
    done = false
    until done
      file = File.read(open("https://api.magicthegathering.io/v1/cards?page=#{page_number.to_s}"))
      hash = JSON.parse(file)
      if hash["cards"] == []
        done = true
      end
      hash["cards"].each do |card|
        unless self.find_by(card_id: card["id"])
          card_info = {}
          card_info[:name] = card["name"] if card["name"] #string
          card_info[:layout] = card["layout"] if card["layout"] #string
          card_info[:cmc] = card["cmc"] if card["cmc"] #string
          card_info[:colors] = card["colors"].join(", ") if card["colors"] #array
          card_info[:color_identity] = card["colorIdentity"].join(", ") if card["colorIdentity"] #array
          card_info[:card_type] = card["type"] if card["type"] #string
          card_info[:supertypes] = card["supertypes"].join(", ") if card["supertypes"] #array
          card_info[:types] = card["types"].join(", ") if card["types"] #array
          card_info[:subtypes] = card["subtypes"].join(", ") if card["subtypes"] #array
          card_info[:rarity] = card["rarity"] if card["rarity"] #string
          card_info[:set_code] = card["set"] if card["set"] #string
          card_info[:setname] = card["setName"] if card["setName"] #string
          card_info[:text] = card["text"] if card["text"] #string
          card_info[:flavor] = card["flavor"] if card["flavor"] #string
          card_info[:artist] = card["artist"] if card["artist"] #string
          card_info[:number] = card["number"] if card["number"] #string
          card_info[:power] = card["power"] if card["power"] #string
          card_info[:toughness] = card["toughness"] if card["toughness"] #string
          card_info[:loyalty] = card["loyalty"] if card["loyalty"] #string
          card_info[:card_id] = card["id"] if card["id"] #string
          card_info[:multiverse_id] = card["multiverseid"] if card["multiverseid"] #string
          card_info[:other_names] = card["names"].join(", ") if card["names"]#array
          card_info[:mana_cost] = card["manaCost"] if card["manaCost"] #string
          card_info[:variations] = card["variations"].join(", ") if card["variations"] #array
          card_info[:image_url] = card["imageUrl"] if card["imageUrl"] #string
          card_info[:watermark] = card["watermark"] if card["watermark"] #string
          card_info[:border] = MTG::Set.find(card["set"]).border unless card["border"]  #string
          card_info[:timeshifted] = card["timeshifted"] if card["timeshifted"] #boolean
          card_info[:hand] = card["hand"] if card["hand"] #string
          card_info[:life] = card["life"] if card["life"] #string
          card_info[:reserved] = card["reserved"] if card["reserved"] # boolean
          card_info[:release_date] = card["releaseDate"] if card["releaseDate"] #string
          card_info[:starter] = card["starter"] if card["starter"] #boolean
          card_info[:rulings] = card["rulings"].collect { |hash| "#{hash["date"]}: #{hash["text"]} "}.join("\n") if card["rulings"]# => array of hashes
          card_info[:original_text] = card["originalText"] if card["originalText"] #string
          card_info[:original_type] = card["originalType"] if card["originalType"] #string
          card_info[:legalities] = card["legalities"].collect { |hash| "#{hash["format"]}: #{hash["legality"]} "}.join("\n") if card["legalities"]#array of hashes
          card_info[:source] = card["source"] if card["source"] #string
          self.find_or_create_by(card_info)
        end
      end
      print "\t#{page_number} pages complete. (370 total pages as of 7/30/18)\r"
      page_number = page_number + 1
    end
  end

end
