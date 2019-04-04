require "webmock/rspec"

module MockHelper
  include WebMock::API

  # WebMock.allow_net_connect!
  WebMock.enable!

  class << self
    def mock_request(key, body, status = 200)
      json = status == 200 ? body.to_json : { errors: body }.to_json
      WebMock.stub_request(:any, /#{key}/).to_return(
        body:    json,
        status:  status,
        headers: { "Content-Type" => "application/json" }
      )
    end

    def encrypt_token(data)
      iv = SecureRandom.hex(8)
      cipher = OpenSSL::Cipher.new("aes-256-cbc")
      cipher.encrypt
      cipher.key = ENV["AES_KEY"]
      cipher.iv  = iv
      [Base64.strict_encode64(iv), Base64.strict_encode64(cipher.update(data) + cipher.final), "200"].join(",")
    end
  end
end
