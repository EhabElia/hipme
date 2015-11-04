class Outfit < ActiveRecord::Base
  belongs_to :user
  ALL_STYLES = [ "Urban", "Hipster", "For a job interview", "For a night out" ]
  ALL_SIZES = [ "165cm", "170cm", "175cm", "180cm", "185cm", "190cm" ]
  geocoded_by :address
  after_validation :geocode

  def address
    user.address
  end
end
