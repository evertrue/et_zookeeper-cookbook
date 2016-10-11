module EtZookeeper
  module Helpers
    def self.ip2id(ip)
      # Uses the last two octets of an IP address to generate a predictable
      # ID between 1 and 255 (for use as `myid`).

      ip_a = ip.split('.')
      ((ip_a[2].to_i / 2) + (ip_a[3].to_i / 2)) + 1
    end
  end
end
