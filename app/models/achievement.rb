class Achievement < ActiveRecord::Base
  default_scope :order => 'section ASC, subsection DESC, created_at DESC'

  has_attached_file :exhibit,
                    :storage => :s3,
                    :s3_credentials => S3_CREDENTIALS,
                    :url => ':s3_domain_url',
                    :path => ":attachment/:style-:id-:basename.:extension",
                    :styles => {
                      :showcase => [ '390x555>', 'png' ],
                      :thumbnail => {
                        :geometry => '35x35#',
                        :format => 'png',
                        :processors => [:jcropper]
                      } }

  validates_attachment_presence :exhibit
  validates_attachment_content_type :exhibit,
    :content_type => %w{ jpeg png gif bmp }.map { |e| "image/#{e}" }
  validates_attachment_size :exhibit,
    :less_than => 2.megabytes

  validate :section, :presence => true
  validate :title, :presence => true

  after_update :reprocess_exhibit, :if => :cropping?

  def cropping?
    exhibit.dirty? && ! %w{x y w h}.any? { |k| send("crop_#{k}").blank? }
  end

  def exhibit_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file exhibit.path(style)
  end

  private

  def reprocess_exhibit
    exhibit.reprocess!
  end
end
