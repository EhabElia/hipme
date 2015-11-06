class User < ActiveRecord::Base

  has_attached_file :picture,
  styles: {medium: "300x300", thumb: "100x100"}
validates_attachment_content_type :picture,
  content_type: /\Aimage\/.*\z/

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook]

  def self.find_for_facebook_oauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.firstname = auth.info.first_name
      user.lastname = auth.info.last_name
      user.picture = process_uri(auth.info.image)
      user.token = auth.credentials.token
      user.token_expiry = Time.at(auth.credentials.expires_at)
    end
  end

  #dependencies
  has_many :outfits, dependent: :destroy # as user
  has_many :bookings, dependent: :destroy
  has_many :outfits_bookings, through: :outfits, source: :bookings

  # User.outfits
  # User.bookings.outfits

  # properties
  validates :firstname, presence: true

  def self.process_uri(uri)
    avatar_url = URI.parse(uri)
    avatar_url.scheme = 'https'
    avatar_url.to_s
  end

end


# current_user.bookings = bookings i've made
# current_user.outfits.each do outfit
# outfit.user_id.





















