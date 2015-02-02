class JournalEntry < ActiveRecord::Base
  validates :dates, :hours, presence: true

  belongs_to :user
  belongs_to :campaign
  has_many :media_files, :dependent => :destroy
  accepts_nested_attributes_for :media_files, :allow_destroy => true

  before_save :mark_media_files_for_removal

  private

  def mark_media_files_for_removal
    self.media_files.each do |mf|
      mf.mark_for_destruction if mf.image.blank?
    end 
  end
end