class Shorty < Sinatra::Application
  configure :development do
    register Sinatra::Reloader
    also_reload 'app/**/*.rb'
  end

  before do
    content_type :json
    body = request.body.read
    @request_payload = Oj.load(body) if body
  end

  post '/shorten' do
    link = Link.new(@request_payload)

    if link.valid? && link.save
      status 201
      Oj.dump('shortcode' => link.shortcode)
    else
      halt 400 if link.errors.include?(:url)
      halt 409 if link.errors.include?(:shortcode) && link.errors[:shortcode].include?('is already taken')
      halt 422 if link.errors.include?(:shortcode)
    end
  end
end
