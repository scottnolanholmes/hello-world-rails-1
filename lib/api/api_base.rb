require "faraday"

class Api::ApiBase
  attr_accessor :conn

  def initialize(url, **opts)
    raise "Plese Override initializer" if url.blank?
    @conn = Faraday.new(url: url) do |builder|
      builder.request  :url_encoded
      builder.response :logger
      builder.adapter  :net_http
    end
  end

  protected

    def get(url, **params)
      res = conn.get do |req|
        req.url(url)
        req.headers = params[:headers] || default_headers
        req.params = params[:body] || {}
      end
      converter(res)
    end

    def post(url, **params)
      res = conn.post do |req|
        req.url(url)
        req.headers = params[:headers] || default_headers
        req.body = params[:body] || {}
      end
      converter(res)
    end

    def converter(res)
      raise "Plese Override this method and define something"
    end

    def default_headers
      { "Content-Type" => "application/json" }
    end
end
