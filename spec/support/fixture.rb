require "json"

module Fixture
  def self.load_json(filename)
    path = Pathname([File.dirname(__FILE__ ), "fixtures", "json", filename].join("/"))
    JSON.parse(File.read(path))
  end

  def self.load_unparsed_json(filename)
    path = Pathname([File.dirname(__FILE__ ), "fixtures", "json", filename].join("/"))
    File.read(path)
  end

  def self.load_signature(filename)
    path = Pathname([File.dirname(__FILE__ ), "fixtures", "signature", filename].join("/"))
    File.read(path)
  end
end
