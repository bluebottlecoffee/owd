require "./test/test_helper"

describe OWD::Request do
  describe 'endpoint' do
    describe 'when environment == "production"' do
      it 'return https://secure.owd.com/webapps/api/api.jsp' do
        assert_equal OWD::Request.new('xml', 'production').endpoint, 'https://secure.owd.com/webapps/api/api.jsp'
      end
    end

    describe 'when environment == "staging"' do
      it 'returns https://secure.owd.com/test/api/api.jsp' do
        assert_equal OWD::Request.new('xml', 'staging').endpoint, 'https://secure.owd.com/test/api/api.jsp'
      end
    end
  end
end
