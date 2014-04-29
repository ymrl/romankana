module RomanKana
  module Utils
    def self.set_encoding_of_before before, after
      e = before.encoding
      return (e == Encoding::US_ASCII or e == Encoding::ASCII_8BIT) ? after : after.encode(e)
    end

    def self.convert_utf8 str
      return (str.encoding != Encoding::UTF_8) ? str.encode(Encoding::UTF_8) : str
    end
  end
end

