# OWD

[![Build Status](https://api.travis-ci.org/bluebottlecoffee/owd.svg?branch=master)](https://travis-ci.org/rochers/owd) [![Code Climate](https://codeclimate.com/github/rochers/owd.svg)](https://codeclimate.com/github/rochers/owd)

The owd gem is a simple client for One World Direct's XML API.

## Configuration

app/config/initializers/owd.rb
```ruby
yaml = YAML.load_file(Rails.root.join('config', 'owd.yml'))[Rails.env]

OWD.configure do |c|
  c.client_id = yaml['client_id']
  c.client_authorization = yaml['client_authorization']
  c.testing = yaml['testing']
  c.environment = yaml['environment']
end

```

or initialize the client directly

```ruby
client = OWD::Client.new(:client_id => 123, :client_authorization => 'XXXXXXXXXX', :environment => 'production')
client.api.inventory_create(:sku => 'MY-FANCY-SKU')
client.api.order_status({ order_reference: 666 })
```

## Installation

```bash
gem install owd
```

## Example Order Create
```ruby
params = {
  order_reference: 'abcdef12345',
  order_source: 'Web',
  backorder_rule: 'PARTIALSHIP',
  hold_for_release: 'NO',
  shipping_info: {
    company_name: 'Billy Bob',
    address_one: '1234 Main Street',
    address_two: 'Second Floor',
    city: 'Santa Monica',
    state: 'CA',
    zip: '90401',
    country: 'United States',
    phone: '1113334444',
    email: 'billy.bob@mail.com',
    ship_type: 'FDX.GND',
    insure_amount: '1.50',
    declared_value: '1.00',
    customs_desc: 'Customs description',
    terms: 'SHIPPER'
  },
  billing_info: {
    paid: 'YES',
    payment_type: 'CLIENT'
  },
  line_items: [
    part_reference: 'SKU',
    description: 'Material name',
    requested: 1,
    cost: 1.50,
    declared_value: 1.00,
    customs_desc: 'Customs description for sku',
    line_number: 'line-item-id',
    is_insert_item: 'NO'
  ]
}
client = OWD::Client.new
response = client.api.order_create(params)
```

## Example Order Update
```ruby
params = {
  order_reference: 'abcdef12345',
  company_name: 'Billy Bob',
  address_one: '1234 Main Street',
  address_two: 'Second Floor',
  city: 'Santa Monica',
  state: 'CA',
  zip: '90401',
  country: 'United States',
  phone: '1113334444',
  email: 'billy.bob@mail.com',
  line_items: [
    part_reference: 'SKU',
    description: 'Material name',
    requested: 1,
    cost: 1.50,
    declared_value: 1.00,
    customs_desc: 'Customs description for sku',
    line_number: 'line-item-id',
    is_insert_item: 'NO'
  ]
}

client = OWD::Client.new
response = client.api.order_update(params)
```

## Example Order Hold
```ruby
client = OWD::Client.new
response = client.api.order_update(order_reference: 'abcdef12345')
```

## Example Order Release
```ruby
client = OWD::Client.new
response = client.api.order_release(order_reference: 'abcdef12345')
```

## Example Order Status
```ruby
client = OWD::Client.new
response = client.api.order_status(order_reference: 'abcdef12345')
```

See OWD's website at http://www.owd.com

## Tests

The test suite can be ran using `rake` or `rake test`.
