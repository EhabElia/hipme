class Outfit < ActiveRecord::Base

  attr_accessor :address

  belongs_to :user
  has_many :bookings

  has_attached_file :picture,
  styles: { large: "800x800>", medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :picture,
  content_type: /\Aimage\/.*\z/

  ALL_STYLES = [ "Urban", "Hipster", "For a job interview", "For a night out" ]
  ALL_SIZES = [ "165cm", "170cm", "175cm", "180cm", "185cm", "190cm" ]

  after_validation :set_address

  geocoded_by :address
  after_validation :geocode

  def set_address
    self.address = "#{self.user.street} #{self.user.zip} #{self.user.city} #{self.user.country}"
  end
end
