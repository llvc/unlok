class Profile < ActiveRecord::Base
  belongs_to :user
  has_attached_file :avatar,
                    :styles => { :large => "300x300>", :medium => "200x200>", :small => "160x160>", :thumb => "32x32>" },
                    :convert_options => { :large => "-quality 85 -strip", :medium => "-quality 85 -strip", :thumb => "-quality 85 -strip", :small => "-quality 85 -strip"},
                    :url => "/users/avatars/:id/:style/:basename.:extension",
                    :default_url => "no-avatar.jpg",
                    :path => "/users/avatars/:id/:style/:basename.:extension",
                    :size => { :in => 0.megabytes..5.megabytes },
                    :storage => :s3,
                    # :s3_credentials => {
                    #     :access_key_id => 'AKIAJ4OMX7NTRG5UO7WA',
                    #     :secret_access_key => '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'
                    # },
                    # :bucket => 'unlokbenno',
                    :s3_credentials => {
                      :access_key_id => ENV['S3_ACCESS_KEY_ID'],
                      :secret_access_key => ENV['S3_SECRET_KEY']
                    },
                    :bucket => ENV['S3_BUCKET'],
                    :url => ":s3_domain_url"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
 

  # validates :name, :presence => {:message => 'cannot be blank'}


end