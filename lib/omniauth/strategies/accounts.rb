require 'omniauth-oauth2'
require 'multi_json'

module OmniAuth
 module Strategies
  class Accounts < OmniAuth::Strategies::OAuth2

    option :name, "accounts"
    option :client_options, {
      :site => 'http://accounts.fromfuture.net',
      :authorize_url => "/authorize",
      :access_token_url => "/token"
    }

    uid{ raw_info['id'] }

    info do
      {
        email: raw_info['email'],
        name: raw_info['name'],
        nickname: raw_info['nickname'],
        first_name: raw_info['first_name'],
        last_name: raw_info['last_name'],
        image: raw_info['image'],
        urls: raw_info['urls'],
        location: raw_info['location'],
        sex: raw_info['sex'],
        born_date: raw_info['born_date']
      }
    end

    extra do
      {
        'raw_info' => raw_info
      }
    end

    def raw_info
      @raw_info ||= access_token.get('/hash.json?access_token='+access_token.token+'&client='+access_token.client.id).parsed
    end

  end
 end
end