class Link < Sequel::Model
  plugin :timestamps, update_on_create: true
  plugin :validation_helpers

  one_to_many :clicks

  def validate
    super
    validates_unique :url, :shortcode
    validates_format URI::Parser.new.make_regexp, :url
    validates_format /^[0-9a-zA-Z_]{4,}$/, :shortcode
  end
end
