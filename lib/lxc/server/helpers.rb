module LXC
  module ServerHelpers
    def json_response(data)
      MultiJson.encode(data)
    end

    def error_response(error, status=400)
      halt(400, json_response(:error => error))
    end

    def find_container
      @container = LXC.container(params[:c_name])
      
      unless @container.exists?
        error_response("Container #{params[:c_name]} does not exist")
      end
    end
  end
end