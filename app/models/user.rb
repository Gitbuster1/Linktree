class User < ApplicationRecord
  extend FriendlyId
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :avatar
  has_many :links, dependent: :destroy

  before_save :downcase_username, :downcase_email
  before_validation :downcase_username, :downcase_email

  after_create :create_default_links
  after_update :create_default_links

  friendly_id :username, use: :slugged

  validates :full_name, length: { maximum: 50 }
  validates :body, length: { maximum: 80 }
  validate :valid_username

  def valid_username
    if User.exists?(username: username.downcase) && username.downcase != username_in_database
      errors.add(:username, 'is already taken')
    end
    restricted_username_list = %(admin root dashboard analytics appearance settings preferences calendar)
    errors.add(:username, 'is restricted') if restricted_username_list.include?(username.downcase)
  end

  def should_generate_new_friendly_id?
    username_changed? || slug.blank?
  end

  private

  def downcase_username
    username.downcase!
    username.strip!
  end

  def downcase_email
    email.downcase!
    email.strip!
  end

  def create_default_links
    Link.create(user: self, title: '', url: '') while links.count < 5
  end
end
