# patches a bug between paperclip and aws-s3
S3_CREDENTIALS =
  if Rails.env == "production"
    # get credentials from the ENV hash (for heroku)
    { :access_key_id => ENV['S3_KEY'],
      :secret_access_key => ENV['S3_SECRET'],
      :bucket => ENV['S3_BUCKET'] }
  else
    # get credentials from YML file
    Rails.root.join('config/s3.yml')
  end
