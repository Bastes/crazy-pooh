class Resume < ActiveRecord::Base
  default_scope :order => 'label ASC'

  has_attached_file :exhibit,
                    :storage => :s3,
                    :s3_credentials => S3_CREDENTIALS,
                    :url => ':s3_domain_url',
                    :path => "resumes/:id-:basename.:extension"

  validates_attachment_presence :exhibit
end
