class Picture < ActiveRecord::Base
  belongs_to :imageable, :polymorphic => true
  
  has_attached_file :image,
                    :styles => { :large => "600x400>", :logo => "224x224>", :medium => "300x300>", :thumb => "160x160>", :tiny => "60x60>" },
                    :convert_options => { :large => "-quality 85 -strip", :logo => "-quality 85 -strip", :medium => "-quality 85 -strip", :thumb => "-quality 85 -strip", :small => "-quality 85 -strip", :tiny => "-quality 85 -strip"},
                    :url => "/pictures/:id/:style/:basename.:extension",
                    :default_url => "/system/default/:style/missing.jpg",
                    :path => "/pictures/:id/:style/:basename.:extension",
                    :size => { :in => 0.megabytes..5.megabytes },
                    :storage => :s3,
                    :s3_credentials => { 
                      :access_key_id => ENV['S3_ACCESS_KEY_ID'], 
                      :secret_access_key => ENV['S3_SECRET_KEY']
                    },
                    :bucket => ENV['S3_BUCKET'],
                    :url => ":s3_domain_url"
 validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
