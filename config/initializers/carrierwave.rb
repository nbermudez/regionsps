    # Configuration for Amazon S3 should be made available through an Environment variable.
    # For local installations, export the env variable through the shell OR
    # if using Passenger, set an Apache environment variable.
    #
    # In Heroku, follow http://devcenter.heroku.com/articles/config-vars
    #
    # $ heroku config:add S3_KEY=your_s3_access_key S3_SECRET=your_s3_secret S3_REGION=eu-west-1 S3_ASSET_URL=http://assets.example.com/ S3_BUCKET_NAME=s3_bucket/folder
    

    CarrierWave.configure do |config|
      if Rails.env.staging? || Rails.env.production?
        config.storage = :fog
        config.fog_credentials = {
            :provider              => 'AWS',
            :aws_access_key_id     => ENV['S3_KEY'],
            :aws_secret_access_key => ENV['S3_SECRET']
        }
        config.cache_dir = "#{Rails.root}/tmp/uploads"
        config.fog_directory    = ENV['S3_BUCKET_NAME']
      else
        config.storage = :file
        config.enable_processing = Rails.env.development?
      end
      #config.fog_public     = false                                   # optional, defaults to true
      #config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
    end