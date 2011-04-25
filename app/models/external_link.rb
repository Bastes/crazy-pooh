class ExternalLink < ActiveRecord::Base
  default_scope :order => 'section ASC, rank ASC'

  has_attached_file :banner,
                    :storage => :s3,
                    :s3_credentials => S3_CREDENTIALS,
                    :url => ':s3_domain_url',
                    :path => "external_links/:id_:basename.:extension",
                    :styles => {
                      :original => {
                        :geometry => "150x",
                        :format => 'png' } }

  validates_attachment_content_type :banner,
    :content_type => %w{ jpeg png gif bmp }.map { |e| "image/#{e}" },
    :unless => Proc.new { |m| m[:banner].nil? }
  validates_attachment_size :banner,
    :less_than => 500.kilobytes,
    :unless => Proc.new { |m| m[:banner].nil? }
  validate :section, :presence => true
  validate :label, :presence => true
  validate :url, :presence => true
end
