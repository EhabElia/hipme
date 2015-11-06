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
  ALL_RANGES = ["2", "5", "10"]

  after_validation :set_address

  geocoded_by :address
  after_validation :geocode

  # true if has booking between 2 dates (format date or string)
  def has_bookings_at_period(checkin_date, checkout_date)
    # convert to date if string
    checkin_date = Date.parse(checkin_date) if checkin_date.is_a? String
    checkout_date = Date.parse(checkout_date) if checkout_date.is_a? String
    # if no consistency in period
    return true if checkout_date < checkout_date
    # prevent charging dataset for more than 100 days long
    return true if (checkout_date-checkin_date) >= 100
    # raise error ?
    self.bookings.each do |booking|
      (booking.checkin..booking.checkout).each do |d|
        # booking for this outfit at these dates
        return true if (checkin_date..checkout_date).include? d
      end
    end
    # no booking at this date
    return false
  end

  def set_address
    self.address = "#{self.user.street} #{self.user.zip} #{self.user.city} #{self.user.country}"
  end
end
