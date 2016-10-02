require "./test/test_helper"

describe OWD::Request do
  before do
    @request = OWD::Request.new(api_request_xml, 15)
  end

  it 'returns an API error on timeout' do
    raises_exception = -> { raise Net::OpenTimeout }
    @request.stub :parse_response, raises_exception do
      assert_raises(OWD::APIError) { @request.perform }
    end
  end

  def api_request_xml
    <<-xml
      <OWD_API_REQUEST api_version='1.0' client_authorization='abc123' client_id='123' testing='FALSE'>
         <OWD_TEST_INVENTORY_SETCOUNT_REQUEST>
           <SKU>BPC-GU-MLBUNIV</SKU>
           <TYPE>ADJUST</TYPE>
           <VALUE>1</VALUE>
         </OWD_TEST_INVENTORY_SETCOUNT_REQUEST>
       </OWD_API_REQUEST>
    xml
  end
end
