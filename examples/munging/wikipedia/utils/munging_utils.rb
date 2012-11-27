# encoding:UTF-8
module MungingUtils
  extend self # you can call MungingUtils.foo, or include it and call on self.

  def time_columns_from_time(time)
    columns = []
    columns << "%04d%02d%02d" % [time.year, time.month, time.day]
    columns << "%02d%02d%02d" % [time.hour, time.min, time.sec]
    columns << time.to_i
    columns << time.wday
    return columns
  end

  NON_PLAIN_ASCII_RE = /[^\x20-\x7e]/m
  CONTROL_CHARS_RE   = /[\x00-\x19]/m

  # Modifies the text in place, replacing all newlines, tabs, and other control
  # characters with a space (those < ascii 0x20, but not including 0xff). This
  # uses a whitelist
  #
  # Only use this if funny characters aren't suppose to be in there in the first
  # place; there are safe, easy ways to properly encode, eg `MultiJson.encode()`
  #
  def scrub_control_chars(text)
    text.gsub!(CONTROL_CHARS_RE, ' ')
    text
  end

  # Modifies the text in place, replacing all non-keyboard characters (newline,
  # tab, anything not between ascii 0x20 and 0x7e) with their XML entity encoding
  def flatten_xml_text(text)
    text.gsub!(NON_PLAIN_ASCII_RE){|char| "&##{char.ord};" };
    text
  end

end

Time.class_eval do
  def to_flat
    utc.strftime("%Y%m%d%H%M%SZ")
  end
end

MatchData.class_eval do
  def as_hash
    Hash[ names.map{|name| [name.to_sym, self[name]] } ]
  end
end
