require 'rubygems'
require 'bundler/setup'
require 'sinatra/base'
require 'sinatra/reloader'
require 'net/https'
require 'json'
require "base64"

if defined? Encoding
    Encoding.default_external = Encoding::UTF_8
  end

  
class App < Sinatra::Base

    configure :development do
        register Sinatra::Reloader
    end

    get '*' do
        json = {
            'attachments' => [
                {'title' => 'URL', 'text' => request.url},
                {'title' => 'param q', 'text' => params['q']},
                {'title' => 'param q base 64 decoded', 'text' => Base64.decode64(params['q'] || "")},
                {'title' => 'User agent', 'text' => request.user_agent},
                {'title' => 'Referer', 'text' => request.referer},
                {'title' => 'Path', 'text' => request.path},
                {'title' => 'IP', 'text' => request.ip},
            ]
        }
        
        url = ENV['canary_slack_web_hook_url']
        if url.to_s.empty?
            raise "Missing environment variable 'canary_slack_web_hook_url'"
        end

        begin 
            uri = URI.parse(url)
            req = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
            req.body = json.to_json
            http = Net::HTTP.new(uri.host, uri.port)
            http.use_ssl = true
            res = http.request(req)
            puts "Response from slack: #{res.body}"
        rescue => e
            puts "Exception thrown #{e}"
        end

        send_file('blank.png', type: 'image/jpeg', disposition: 'inline')
    end

end
