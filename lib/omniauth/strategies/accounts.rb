require 'omniauth-oauth2'
require 'multi_json'

module OmniAuth
 module Strategies
  class Accounts < OmniAuth::Strategies::OAuth2

    option :name, "accounts"
    option :client_options, {
      :site => 'http://accounts.fromfuture.net',
      :authorize_url => "/authorize",
      :access_token_url => "/access_token"
    }

    uid{ raw_info['id'] }

    info do
      {
        :name => raw_info['name'],
        :email => raw_info['email']
      }
    end

    extra do
      {
        'raw_info' => raw_info
      }
    end

    def raw_info
      @raw_info ||= access_token.get('/account.json?access_token='+access_token.token+'&client='+access_token.client.id).parsed
    end

  end
 end
end