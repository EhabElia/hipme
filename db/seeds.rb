# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# SEEDS
hipword = ["look", "style", "fame", "allure", "genre", "air", "eleganza", "elegance", "apparence", "chic", "posture"]
all_styles = Outfit::ALL_STYLES
all_sizes = Outfit::ALL_SIZES

# seed global configuration
clean_before_seed = true; # clean objects before seeding
print_to_console = true; # = test only when you edit this file (production : TRUE)
save_object = true; # does not save the objects to db = test only when you edit this file

# seed configuration for OUTFITS
style_per_user = 5; # number of styles generated for each user

########################################
#                                      #
# SEED EXECUTION BELOW - DON'T CHANGE IT
#                                      #
########################################

# create X styles for each user
Outfit.delete_all if clean_before_seed
User.all.each do |user|
  style_per_user.times {
    new_outfit = Outfit.new(
        title: Faker::Name.first_name + "'s " + Faker::Commerce.color + " " + hipword[rand(hipword.size-1)],
        description: Faker::Lorem.paragraphs(1, true),
        price: ((rand(10) + 5) * 5 - 1) + 0.99, # price from 24.99 to 74.99
        size: all_sizes[rand(all_sizes.size-1)],
        style: all_styles[rand(all_sizes.size-1)],
        user_id: user.id
      )
    new_outfit.save if save_object
    p new_outfit if print_to_console
  }
end
