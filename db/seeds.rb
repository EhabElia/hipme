# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require "faker"
# SEEDS
hipword = ["look", "style", "fame", "allure", "genre", "air", "eleganza", "elegance", "apparence", "chic", "posture","etsy", "twee", "hoodie", "Banksy", "retro", "synth", "single-origin coffee",
      "art", "party", "cliche", "artisan", "Williamsburg", "squid",
      "helvetica", "keytar", "American Apparel", "craft beer", "food truck",
      "you probably haven't heard of them", "cardigan", "aesthetic", "raw denim",
      "sartorial", "gentrify", "lomo", "vice", "Pitchfork", "Austin",
      "sustainable", "salvia", "organic", "thundercats", "PBR", "iPhone",
      "lo-fi", "skateboard", "jean shorts", "next level", "beard", "tattooed",
      "trust fund", "Four Loko", "master cleanse", "ethical", "high life",
      "wolf", "moon", "fanny pack", "8-bit", "Carles",
      "Shoreditch", "seitan", "freegan", "keffiyeh", "biodiesel", "quinoa",
      "farm-to-table", "fixie", "viral", "chambray", "scenester", "leggings",
      "readymade", "Brooklyn", "Wayfarers", "Marfa", "put a bird on it",
      "dreamcatcher", "photo booth", "tofu", "mlkshk", "vegan", "vinyl", "DIY",
      "banh mi", "bicycle rights", "before they sold out", "gluten-free", "yr",
      "butcher", "blog", "whatever", "+1", "Cosby Sweater", "VHS", "messenger bag",
      "cred", "locavore", "mustache", "tumblr", "Portland", "mixtape", "fap",
      "letterpress", "McSweeney's", "stumptown", "brunch",
      "irony", "echo park"]
all_styles = Outfit::ALL_STYLES
all_sizes = Outfit::ALL_SIZES

# seed global configuration
clean_before_seed = true; # clean objects before seeding
print_to_console = true; # = test only when you edit this file (production : TRUE)
save_object = true; # does not save the objects to db = test only when you edit this file

# seed configuration for OUTFITS
style_per_user = 5; # number of styles generated for each user

##########################################
#                                        #
# SEED EXECUTION BELOW - DON'T CHANGE IT #
#                                        #
##########################################

# create 1 user for each tester
User.destroy_all if clean_before_seed
User.create(email: "max@hipme.fr", firstname: "maxime", password: "uriennnn", country: "FR", city: "Paris", zip: "75001", street: "22 place Vendome")
User.create(email: "pedro@hipme.fr", firstname: "pedro", password: "duqueeee", country: "FR", city: "Paris", zip: "75004", street: "41 boulevard bourdon")
User.create(email: "ehab@hipme.fr", firstname: "ehab", password: "eliaaaaa", country: "FR", city: "Paris", zip: "75011", street: "16 villa Gaudelet")

# create X styles for each user
Outfit.delete_all if clean_before_seed
User.all.each do |user|
  puts "-----\nCreating Outfit for user : #{user.email.upcase}" if print_to_console
  style_per_user.times {
   new_outfit = Outfit.new(
        title: Faker::Name.first_name + "'s " + hipword[rand(hipword.size-1)] + ([true, false].sample ? " " : " #{Faker::Commerce.color} ") + hipword[rand(hipword.size-1)],
        description: Faker::Lorem.sentences(10),
        price: ((rand(10) + 5) * 5 - 1) + 0.99, # price from 24.99 to 74.99
        size: all_sizes[rand(all_sizes.size-1)],
        style: all_styles[rand(all_sizes.size-1)],
        user_id: user.id
      )
    new_outfit.save if save_object
    p new_outfit if print_to_console
  }
end
