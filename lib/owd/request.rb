module OWD
  class Request
    ENDPOINT = 'https://secure.owd.com/api/api.jsp'
    STAGING_ENDPOINT = 'https://secure.owd.com/test/api/api.jsp'

    attr_reader :xml, :environment

    def initialize(xml, environment = 'staging')
      @xml = xml
      @environment = environment
    end

    def perform
      uri = URI.parse(endpoint)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = (uri.scheme == 'https')

      request = Net::HTTP::Post.new(uri.request_uri)
      request.body = xml

      request["Content-Type"] = "text/xml"
      parse_response(http.request(request))
    end

    def endpoint
      @endpoint ||= @environment == 'production' ? ENDPOINT : STAGING_ENDPOINT
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
