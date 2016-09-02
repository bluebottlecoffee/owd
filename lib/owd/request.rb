module OWD
  class Request
    ENDPOINT = 'https://secure.owd.com/webapps/api/api.jsp'

    attr_reader :xml, :timeout_seconds

    def initialize(xml, timeout_seconds)
      @xml = xml
      @timeout_seconds = timeout_seconds
    end

    def perform
      uri = URI.parse(ENDPOINT)
      http = Net::HTTP.new(uri.host, uri.port)
      http.read_timeout = timeout_seconds
      http.open_timeout = timeout_seconds
      http.use_ssl = (uri.scheme == 'https')

      request = Net::HTTP::Post.new(uri.request_uri)
      request.body = xml
      request["Content-Type"] = "text/xml"

      parse_response(http.request(request))
    end

    private

    def parse_response(response)
      Crack::XML.parse(response.body)['OWD_API_RESPONSE'].tap do |results|
        if results['results'] == 'ERROR'
          raise APIError.new 'type'    => results['error_type'],
                             'message' => results['error_response']
        end
      end
    end
  end
end
