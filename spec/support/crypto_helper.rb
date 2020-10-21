require "pathname"
require "openssl"

module CryptoHelper
  FIXTURE_DIRECTORY = Pathname.getwd().join("spec", "support", "fixtures", "signature")

  def self.load_certificate(name)
    pem = File.read(FIXTURE_DIRECTORY.join("#{name}-certificate.pem"))
    ::OpenSSL::X509::Certificate.new(pem)
  end

  def self.load_public_key(name)
    pem = File.read(FIXTURE_DIRECTORY.join("#{name}-public_key.pem"))
    ::OpenSSL::PKey::RSA.new(pem)
  end

  def self.load_private_key(name)
    pem = File.read(FIXTURE_DIRECTORY.join("#{name}-private_key.pem"))
    ::OpenSSL::PKey::RSA.new(pem)
  end
end