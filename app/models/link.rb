class Link < Sequel::Model
  plugin :timestamps, update_on_create: true
  plugin :validation_helpers

  one_to_many :clicks

  def validate
    super
    validates_unique :shortcode
    validates_format URI::Parser.new.make_regexp, :url
    validates_format /^[0-9a-zA-Z_]{4,}$/, :shortcode
  end

  def before_validation
    self.shortcode ||= generate_random_shortcode
    super
  end

  def start_date
    created_at.iso8601
  end

  def last_seen_date
    clicks.last.created_at.iso8601 unless clicks.empty?
  end

  private

  def generate_random_shortcode
    SecureRandom.urlsafe_base64(4)
  end
end
