require 'rubygems'
require 'sinatra'
require 'tropo-webapi-ruby'

class VoicepinController < ApplicationController

post '/ask.json' do
    tropo = Tropo::Generator.new do
              on :event => 'hangup', :next => '/hangup.json'
              on :event => 'continue', :next => '/answer.json'
              ask({ :name    => 'pin_number',
                    :bargein => true,
                    :timeout => 30,
                    :require => 'true' }) do
                      say     :value => 'Please enter your pin number'
                      choices :value => '[4 DIGITS]'
                    end
              end
    tropo.response
  end

  # Produces a Ruby hash, if the user gives a response before hanging up:
  #
  # { :result =>
  #   { :actions          => { :attempts       => 1,
  #                            :disposition    => "SUCCESS",
  #                            :interpretation => "12345",
  #                            :confidence     => 100,
  #                            :name           => "account_number",
  #                            :utterance      => "1 2 3 4 5" },
  #     :session_duration => 3,
  #     :error            => nil,
  #     :sequence         => 1,
  #     :session_id       => "5325C262-1DD2-11B2-8F5B-C16F64C1D62E@127.0.0.1",
  #     :state            => "ANSWERED",
  #     :complete         => true } }
  #
  # tropo_event = Tropo::Generator.parse request.env["rack.input"].read
  # All three of these are now valid with Hashie
  # 'Call Answered!' if tropo_event.result.call_state == 'Answered'
  # 'Call Answered!' if tropo_event[:result][:call_state] == 'Answered'
  # 'Call Answered!' if tropo_event['result']['call_state'] == 'Answered'

  post '/answer.json' do
    tropo_event = Tropo::Generator.parse request.env["rack.input"].read
    #p tropo_event
    p 'PIN Verified!' if tropo_event.result.call_state == 'Answered'
  end

  # Produces a Ruby hash, if the user hangs up before giving a reponse
  # { :result =>
  #   { :actions          => {},
  #     :session_duration => 1,
  #     :error            => nil,
  #     :sequence         => 1,
  #     :session_id       => "812BEF50-1DD2-11B2-8F5B-C16F64C1D62E@127.0.0.1",
  #     :state            => "DISCONNECTED",
  #     :complete         => true } }
  #
  post '/hangup.json' do
    tropo_event = Tropo::Generator.parse request.env["rack.input"].read
    p tropo_event
  end

end
