# frozen_string_literal: true

require "test_helper"

class IpgeobaseTest < TestCase

  def setup
    @ip = '8.8.8.8'
    @bad_ip = '222222'
    @stub = stub_request(:get, "http://ip-api.com/xml/#{@ip}").
      with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => load_fixture('response.xml'), :headers => {})
    @stub_bad_request = stub_request(:get, "http://ip-api.com/xml/#{@bad_ip}").
      with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => load_fixture('response_bad_request.xml'), :headers => {})
  end

  def test_that_it_has_a_version_number
    refute_nil ::Ipgeobase::VERSION
  end

  def test_lookup
    Ipgeobase.lookup @ip

    assert_requested @stub
  end

  def test_bad_lookup
    Ipgeobase.lookup @bad_ip

    assert_requested @stub_bad_request
  end

  def test_params
    data = Ipgeobase.lookup @ip

    assert_equal "Ashburn", data.city
    assert_equal "United States", data.country
    assert_equal "US", data.countryCode
    assert_equal "39.03", data.lat
    assert_equal "-77.5", data.lon
  end
end
