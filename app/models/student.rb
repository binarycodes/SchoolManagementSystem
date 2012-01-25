
class Student < ActiveRecord::Base

  attr_accessible :first_name, :middle_name, :last_name, :gender, :date_of_birth, :image

  mount_uploader :image, ImageUploader

  validates :first_name, :last_name, :presence => true
  validates :first_name, :middle_name, :last_name, :length => {:maximum => 30}
  validates :first_name, :last_name, :length => {:minimum=>3}
  validates :first_name, :middle_name, :last_name, :format => {:with => /\A[a-zA-Z]*\Z/, :message => "cannot have non-alphabetical characters"}

  validates :date_of_birth, :presence => true
  validates :gender, :presence => true
  validates :gender, :inclusion => { :in => %w(male female), :message => 'value %{value} is not valid for gender'}

  validate :birthday_check

  scope :prev, lambda { |s|
    where("created_at > ?", s.created_at).select("id").order("created_at ASC").limit(1)
  }
  scope :next, lambda { |s|
    where("created_at < ?", s.created_at).select("id").order("created_at DESC").limit(1)
  }


  def full_name
    [first_name, middle_name, last_name].join(' ');
  end

  def birthday_check
    min_age = 1
    if date_of_birth.to_datetime > min_age.years.ago
      errors.add(:date_of_birth, "can't be less than #{min_age} year ago")
    end
  end

  def self.search(search)
    if search
      Student.where("first_name LIKE :search OR middle_name LIKE :search OR last_name LIKE :search",
                    {:search => "%#{search}%"}).order("first_name ASC")
    else
      Student.order("created_at DESC")
    end
  end
end
