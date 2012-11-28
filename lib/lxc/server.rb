require 'sinatra/base'
require 'multi_json'
require 'lxc/server/version'
require 'lxc/server/helpers'

module LXC
  class Server < Sinatra::Base
    set :environment, ENV['RACK_ENV'] || 'production'

    helpers do
      include LXC::ServerHelpers
    end
    
    before do
      content_type :json, :encoding => :utf8
    end
    
    error do
      err = env['sinatra.error']
      content_type :json, :encoding => :utf8
      json_response(:error => {:message => err.message, :type => err.class.to_s})
    end
    
    not_found do
      content_type :json, :encoding => :utf8
      json_response(:error => "Invalid request path")
    end
    
    get '/version' do
      json_response('version' => LXC::SERVER_VERSION)
    end

    get '/lxc_version' do
      json_response('version' => LXC.version)
    end

    get '/containers' do
      containers = LXC.containers
      json_response(containers.map(&:to_hash))
    end

    get '/containers/:c_name' do
      find_container
      json_response(@container.to_hash)
    end

    get '/containers/:c_name/:action' do
      find_container

      case params[:action]
        when 'processes'
          json_response(@container.processes)
        when 'memory'
          json_response(:memory => @container.memory_usage)
        else
          error_response("Invalid action")
      end
    end

    post '/containers/:c_name/:action' do
      find_container
      case params[:action]
      when 'start', 'stop', 'restart', 'freeze', 'unfreeze'
        @container.send(params[:action].to_sym)
      when 'destroy'
        begin 
          @container.destroy
        rescue LXC::ContainerError => err
          error_response(err.message)
        end
      else
        error_response("Invalid action")
      end
      json_response(@container.to_hash)
    end
  end
end