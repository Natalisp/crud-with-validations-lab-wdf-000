class Song < ActiveRecord::Base
  validates :title, presence: true, uniqueness: true
  validate :already_same
  validates :released, inclusion: { in: [ true, false ] }
  validates :release_year, presence: true, if: :released?
  validate :release_year_conditions
  validates :artist_name, presence: true


  def already_same
    if :artist_name == artist_name && :release_year == release_year
    errors.add( title, "already released this year by the artist!")
   end
  end

  def release_year_conditions
    current_year = Time.now.year.to_i
    if release_year >= current_year
      errors.add(:release_year, "must be less than or equal to the current year")
   end
  end

end
