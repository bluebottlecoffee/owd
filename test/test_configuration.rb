require "./test/test_helper"

describe OWD do
  before do
    OWD.configure do |config|
      config.client_id = 123
      config.client_authorization = 'abc'
      config.testing = false
      config.environment = 'production'
    end
  end

  describe 'global configuration' do
    it { assert_equal OWD.configuration.client_id, 123 }
    it { assert_equal OWD.configuration.client_authorization, 'abc' }
    it { assert_equal OWD.configuration.testing, false }
    it { assert_equal OWD.configuration.environment, 'production' }
  end

  describe 'client' do
    it 'will use global configuration if no credentials passed on initialize' do
      client = OWD::Client.new
      assert_equal client.client_id, 123
      assert_equal client.client_authorization, 'abc'
      assert_equal client.testing, 'FALSE'
      assert_equal client.environment, 'production'
    end

    it 'will override global configuration if credentials passed on initialize' do
      client = OWD::Client.new(client_id: 321, client_authorization: 'xyz', testing: true, environment: 'staging')
      assert_equal client.client_id, 321
      assert_equal client.client_authorization, 'xyz'
      assert_equal client.testing, 'TRUE'
      assert_equal client.environment, 'staging'
    end
  end
end
