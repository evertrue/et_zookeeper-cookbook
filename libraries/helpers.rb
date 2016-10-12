module EtZookeeper
  module Helpers
    def self.name2id(name)
      # Uses a name to generate a predictable ID between 1 and 255 (for use as `myid`).
      require 'zlib'

      n = Zlib.crc32(name)/1024/1024/16

      # CRC32 has limits *just slightly* outside ZK's acceptable range
      case n
      when 0
        1
      when 256
        255
      else
        n
      end
    end
  end
end
