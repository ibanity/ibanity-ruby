require "json"

module Fixture
  def self.load_json(filename)
    path = Pathname([File.dirname(__FILE__ ), "fixtures", "json", filename].join("/"))
    JSON.parse(File.read(path))
  end
end
