# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require "faker"
require "csv"


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

cities = []
csv_options = { col_sep: ';', headers: :first_row }
CSV.foreach(File.dirname(__FILE__) + "/cp.csv", csv_options) do |row|
  cities << [row[0].strip, row[1].strip]
end

common_streets = [
  "rue de l'Eglise",
  "place de l'Eglise",
  "grande rue",
  "rue du moulin",
  "place de la mairie",
  "rue du château",
  "rue des écoles",
  "rue de la gare",
  "rue de la mairie",
  "rue principale",
  "rue du stade",
  "rue de la fontaine",
  "rue pasteur",
  "rue des jardins",
  "rue Victor Hugo"
]

# seed global configuration
clean_before_seed = true; # clean objects before seeding
print_to_console = false; # = test only when you edit this file (production : TRUE)
save_object = true; # does not save the objects to db = test only when you edit this file

# seed configuration
users = 100; # number of users in addition to us (3 : pedro, max, ehab)
style_per_user = (3..10); # number of styles generated for each user
booking_per_user = (2..7)

##########################################
#                                        #
# SEED EXECUTION BELOW - DON'T CHANGE IT #
#                                        #
##########################################

# clean everything if necessary

if clean_before_seed
  User.all.each do |user|
    user.bookings.destroy_all
    user.outfits.destroy_all
  end
  User.destroy_all
end

# create 1 user for each tester
User.create(email: "max@hipme.fr", firstname: "maxime", password: "uriennnn", country: "FR", city: "Paris", zip: "75011", street: "44 bis rue de Montreuil")
User.create(email: "pedro@hipme.fr", firstname: "pedro", password: "duqueeee", country: "FR", city: "Paris", zip: "75004", street: "41 boulevard bourdon")
User.create(email: "ehab@hipme.fr", firstname: "ehab", password: "eliaaaaa", country: "FR", city: "Paris", zip: "75011", street: "16 villa Gaudelet")

# create X additional users with french city
users.times do
  city = cities[rand(cities.size - 1)]
  new_user = User.new(
    email: Faker::Internet.safe_email,
    firstname: Faker::Name.first_name,
    lastname: Faker::Name.last_name,
    password: Faker::Internet.password(8, 8),
    country: "France",
    city: city[0].downcase.capitalize,
    zip: city[1].to_i,
    street: common_streets[rand(common_streets.size - 1)]
  )
  new_user.save if save_object
  p new_user if print_to_console
end

# create X styles for each user
User.all.each do |user|

  x = rand(style_per_user)
  puts "\n-----\nCreating #{x} outfits for user : #{user.email.upcase}" if print_to_console
  x.times do
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
  end

  x = rand(booking_per_user)
  puts "\n-----\nCreating #{x} bookings for user : #{user.email.upcase}" if print_to_console
  x.times do
    outfit = Outfit.all[rand(Outfit.all.size)]
    checkin = Date.today + (rand(365)) * (-1..+1).to_a.sample.to_i
    checkout = checkin + rand(2..5)
    new_booking = Booking.new(
      checkin: checkin,
      checkout: checkout,
      user_id: user.id,
      outfit_id: outfit.id,
      total_price: (((checkout - checkin) * outfit.price) * 100).round / 100
    )
    new_booking.save if save_object
    p new_booking if print_to_console
  end

end

puts "\n\n\n"
puts "User generated: #{User.all.size}"
puts "Outfits generated: #{Outfit.all.size}"
puts "Bookings generated: #{Booking.all.size}"
puts "\n"
puts "Have a good day, sir."
puts "\n"

