class Movie < ActiveRecord::Base
  validates :title, presence: true
  validates :director, presence: true
  validates :runtime_in_minutes, numericality: { only_integer: true }
  validates :description, presence: true
  validates :release_date, presence: true
  validate :release_date_is_in_the_past
  has_many :reviews

  mount_uploader :image, AvatarUploader

  scope :search, -> (title_director) { where("title LIKE ? OR director LIKE ?", title_director, title_director) }
  scope :under_90, -> { where("runtime_in_minutes < 90") }
  scope :over_120, -> { where("runtime_in_minutes > 120") }
  scope :between_90_and_120, -> { where("runtime_in_minutes BETWEEN 90 AND 120") }

  def review_average
   reviews.size != 0 ? reviews.sum(:rating_out_of_ten)/reviews.size : "N/A"
  end


  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "Should be in the past!") if release_date > Date.today
    end
  end

end
