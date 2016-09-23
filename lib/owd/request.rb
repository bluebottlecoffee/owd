module OWD
  class Request
    ENDPOINT = 'https://secure.owd.com/webapps/api/api.jsp'

    attr_reader :xml, :timeout_seconds, :uri

    def initialize(xml, timeout_seconds)
      @xml = xml
      @timeout_seconds = timeout_seconds.to_i
      @uri = URI.parse(ENDPOINT)
    end

    def perform
      parse_response
    rescue Net::OpenTimeout
      raise APIError.new({
        'type' => 'Timeout',
        'message' => 'Request timed out'})
    end

    private

    def client
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = (uri.scheme == 'https')
      http.open_timeout = timeout_seconds
      http.read_timeout = timeout_seconds
      http
    end

    def request_parameters
      request = Net::HTTP::Post.new(uri.request_uri)
      request.body = xml
      request["Content-Type"] = "text/xml"
      request
    end

    def response
      @response ||= client.request(request_parameters)
    end

    def parse_response
      Crack::XML.parse(response.body)['OWD_API_RESPONSE'].tap do |results|
        if results['results'] == 'ERROR'
          raise APIError.new 'type'    => results['error_type'],
                             'message' => results['error_response']
        end
      end
    end
  end
end
