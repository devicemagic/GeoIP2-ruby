# frozen_string_literal: true

require 'ipaddr'
require 'maxmind/geoip2/record/abstract'

module MaxMind::GeoIP2::Record
  # Contains data for the traits record associated with an IP address.
  #
  # This record is returned by all location services and databases.
  class Traits < Abstract
    def initialize(record) # :nodoc:
      super(record)
      if !record.key?('network') && record.key?('ip_address') &&
         record.key?('prefix_length')
        ip = IPAddr.new(
          format('%s/%d', record['ip_address'], record['prefix_length']),
        )
        # We could use ip.prefix instead of record['prefix_length'], but that
        # method only becomes available in Ruby 2.5+.
        record['network'] = format('%s/%d', ip.to_s, record['prefix_length'])
      end
    end

    # The autonomous system number associated with the IP address. See
    # Wikipedia[https://en.wikipedia.org/wiki/Autonomous_system_(Internet)].
    # This attribute is only available from the City and Insights web service
    # and the GeoIP2 Enterprise database. Integer but may be nil.
    def autonomous_system_number
      get('autonomous_system_number')
    end

    # The organization associated with the registered autonomous system number
    # for the IP address. See
    # Wikipedia[https://en.wikipedia.org/wiki/Autonomous_system_(Internet)].
    # This attribute is only available from the City and Insights web service
    # and the GeoIP2 Enterprise database. String but may be nil.
    def autonomous_system_organization
      get('autonomous_system_organization')
    end

    # The connection type may take the following  values: "Dialup",
    # "Cable/DSL", "Corporate", "Cellular". Additional values may be added in
    # the future. This attribute is only available in the GeoIP2 Enterprise
    # database. String but may be nil.
    def connection_type
      get('connection_type')
    end

    # The second level domain associated with the IP address. This will be
    # something like "example.com" or "example.co.uk", not "foo.example.com".
    # This attribute is only available from the City and Insights web service
    # and the GeoIP2 Enterprise database. String but may be nil.
    def domain
      get('domain')
    end

    # The IP address that the data in the model is for. If you performed a "me"
    # lookup against the web service, this will be the externally routable IP
    # address for the system the code is running on. If the system is behind a
    # NAT, this may differ from the IP address locally assigned to it. This
    # attribute is returned by all end points. String.
    def ip_address
      get('ip_address')
    end

    # This is true if the IP address belongs to any sort of anonymous network.
    # This property is only available from GeoIP2 Precision Insights. Boolean.
    def anonymous?
      get('is_anonymous')
    end

    # This is true if the IP address is registered to an anonymous VPN
    # provider. If a VPN provider does not register subnets under names
    # associated with them, we will likely only flag their IP ranges using the
    # hosting_provider? property. This property is only available from GeoIP2
    # Precision Insights. Boolean.
    def anonymous_vpn?
      get('is_anonymous_vpn')
    end

    # This is true if the IP address belongs to a hosting or VPN provider (see
    # description of the anonymous_vpn? property). This property is only
    # available from GeoIP2 Precision Insights. Boolean.
    def hosting_provider?
      get('is_hosting_provider')
    end

    # This attribute is true if MaxMind believes this IP address to be a
    # legitimate proxy, such as an internal VPN used by a corporation. This
    # attribute is only available in the GeoIP2 Enterprise database. Boolean.
    def legitimate_proxy?
      get('is_legitimate_proxy')
    end

    # This is true if the IP address belongs to a public proxy. This property
    # is only available from GeoIP2 Precision Insights. Boolean.
    def public_proxy?
      get('is_public_proxy')
    end

    # This is true if the IP address is a Tor exit node. This property is only
    # available from GeoIP2 Precision Insights. Boolean.
    def tor_exit_node?
      get('is_tor_exit_node')
    end

    # The name of the ISP associated with the IP address. This attribute is
    # only available from the City and Insights web services and the GeoIP2
    # Enterprise database. String but may be nil.
    def isp
      get('isp')
    end

    # The network in CIDR notation associated with the record. In particular,
    # this is the largest network where all of the fields besides ip_address
    # have the same value. String.
    def network
      get('network')
    end

    # The name of the organization associated with the IP address. This
    # attribute is only available from the City and Insights web services and
    # the GeoIP2 Enterprise database. String but may be nil.
    def organization
      get('organization')
    end

    # An indicator of how static or dynamic an IP address is. This property is
    # only available from GeoIP2 Precision Insights. Float but may be nil.
    def static_ip_score
      get('static_ip_score')
    end

    # The estimated number of users sharing the IP/network during the past 24
    # hours. For IPv4, the count is for the individual IP. For IPv6, the count
    # is for the /64 network. This property is only available from GeoIP2
    # Precision Insights. Integer but may be nil.
    def user_count
      get('user_count')
    end

    # The user type associated with the IP address. This can be one of the
    # following values:
    #
    # * business
    # * cafe
    # * cellular
    # * college
    # * content_delivery_network
    # * dialup
    # * government
    # * hosting
    # * library
    # * military
    # * residential
    # * router
    # * school
    # * search_engine_spider
    # * traveler
    #
    # This attribute is only available from the Insights web service and the
    # GeoIP2 Enterprise database.
    #
    # May be nil.
    def user_type
      get('user_type')
    end
  end
end