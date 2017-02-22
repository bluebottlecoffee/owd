require 'owd/documents/order_update'
require 'test_helper'

describe OWD::OrderUpdate do
  before do
    @doc = OWD::OrderUpdate.new
  end

  describe '#owd_name' do
    it { assert_equal @doc.owd_name, 'OWD_ORDER_UPDATE_REQUEST' }
  end

  describe '#build' do
    it 'builds an XML body with an :order_reference' do
      assert_equal_xml @doc.build(
        order_reference: 123,
        shipping_method: 'FDX.STD',
        first_name: "Joe",
        address_one: "300 Webster Street",
        city: "Oakland",
        state: "CA",
        email: "email@gmail.com",
        zip: "94607",
        country: "US",
        phone: "555-5555"
      ), <<-XML
        <?xml version="1.0" encoding="UTF-8"?>
        <OWD_API_REQUEST>
          <OWD_ORDER_UPDATE_REQUEST clientOrderId="123">
            <SHIPPING_METHOD>FDX.STD</SHIPPING_METHOD>
            <SHIP_NAME>Joe</SHIP_NAME>
            <SHIP_ADDRESS_ONE>300 Webster Street</SHIP_ADDRESS_ONE>
            <SHIP_CITY>Oakland</SHIP_CITY>
            <SHIP_STATE>CA</SHIP_STATE>
            <SHIP_POSTCODE>94607</SHIP_POSTCODE>
            <SHIP_COUNTRY>US</SHIP_COUNTRY>
            <SHIP_PHONE>555-5555</SHIP_PHONE>
            <SHIP_EMAIL>email@gmail.com</SHIP_EMAIL>
          </OWD_ORDER_UPDATE_REQUEST>
        </OWD_API_REQUEST>
      XML
    end

    it 'builds an XML body with line_items if present' do
      assert_equal_xml @doc.build(
        order_reference: 123,
        line_items: [
          part_reference: 'SKU',
          description: 'Material Name',
          requested: 11,
          cost: '1.5',
          declared_value: '1.0',
          customs_desc: 'Customs description',
          line_number: '123-line-item',
          is_insert_item: 'NO'
        ]
      ), <<-XML
        <?xml version="1.0" encoding="UTF-8"?>
        <OWD_API_REQUEST>
          <OWD_ORDER_UPDATE_REQUEST clientOrderId="123">
            <LINE_ITEMS>
              <LINE_ITEM part_reference="SKU" description="Material Name" requested="11" cost="1.5" declared_value="1.0" customs_desc="Customs description" line_number="123-line-item" is_insert_item="NO" />
            </LINE_ITEMS>
          </OWD_ORDER_UPDATE_REQUEST>
        </OWD_API_REQUEST>
      XML
    end

    it 'builds an XML body with bill_to if present' do
      assert_equal_xml @doc.build(
        order_reference: 123,
        bill_to: {
          company_name: "Revolution",
          first_name: "Joe",
          address_one: "300 Webster Street",
          city: "Oakland",
          state: "CA",
          email: "email@gmail.com",
          zip: "94607",
          country: "US",
          phone: "555-5555"

        }
      ), <<-XML
        <?xml version="1.0" encoding="UTF-8"?>
        <OWD_API_REQUEST>
          <OWD_ORDER_UPDATE_REQUEST clientOrderId="123">
            <BILL_COMPANY>Revolution</BILL_COMPANY>
            <BILL_NAME>Joe</BILL_NAME>
            <BILL_ADDRESS_ONE>300 Webster Street</BILL_ADDRESS_ONE>
            <BILL_CITY>Oakland</BILL_CITY>
            <BILL_STATE>CA</BILL_STATE>
            <BILL_POSTCODE>94607</BILL_POSTCODE>
            <BILL_COUNTRY>US</BILL_COUNTRY>
            <BILL_PHONE>555-5555</BILL_PHONE>
            <BILL_EMAIL>email@gmail.com</BILL_EMAIL>
          </OWD_ORDER_UPDATE_REQUEST>
        </OWD_API_REQUEST>
      XML
    end

  end
end
