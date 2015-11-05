class Outfit < ActiveRecord::Base
  belongs_to :user
  has_attached_file :picture,
  styles: { large: "800x800>", medium: "300x300>", thumb: "100x100>" }

  validates_attachment_content_type :picture,
  content_type: /\Aimage\/.*\z/
  ALL_STYLES = [ "Urban", "Hipster", "For a job interview", "For a night out" ]
  ALL_SIZES = [ "165cm", "170cm", "175cm", "180cm", "185cm", "190cm" ]
end
