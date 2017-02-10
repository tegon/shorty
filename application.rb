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

  get '/' do
    Oj.dump({})
  end

  post '/' do
    Oj.dump(@request_payload)
  end
end
