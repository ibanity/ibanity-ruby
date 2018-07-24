require 'base64'
require 'openssl'

describe Ibanity::HttpSignature do
  let(:cert) {
    OpenSSL::X509::Certificate.new(
        '-----BEGIN CERTIFICATE-----
MIIFszCCBJugAwIBAgIQdRjsz/MgcDhfRrPq4nHyKzANBgkqhkiG9w0BAQsFADB3
MQswCQYDVQQGEwJVUzEdMBsGA1UEChMUU3ltYW50ZWMgQ29ycG9yYXRpb24xHzAd
BgNVBAsTFlN5bWFudGVjIFRydXN0IE5ldHdvcmsxKDAmBgNVBAMTH1N5bWFudGVj
IENsYXNzIDMgRVYgU1NMIENBIC0gRzMwHhcNMTQwOTIyMDAwMDAwWhcNMTYwOTIy
MjM1OTU5WjCCASIxEzARBgsrBgEEAYI3PAIBAxMCREUxFTATBgsrBgEEAYI3PAIB
AQwEQm9ubjEdMBsGA1UEDxMUUHJpdmF0ZSBPcmdhbml6YXRpb24xEDAOBgNVBAUT
B0hSQjY3OTMxCzAJBgNVBAYTAkRFMQ4wDAYDVQQRDAU1MzExMzEcMBoGA1UECAwT
Tm9yZHJoZWluLVdlc3RmYWxlbjENMAsGA1UEBwwEQm9ubjEmMCQGA1UECQwdRnJp
ZWRyaWNoIEViZXJ0IEFsbGVlIDExNCAxMjYxHTAbBgNVBAoMFERldXRzY2hlIFBv
c3RiYW5rIEFHMRwwGgYDVQQLDBNQb3N0YmFuayBTeXN0ZW1zIEFHMRQwEgYDVQQD
DAtwb3N0YmFuay5kZTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALyM
MCzg46AWq8eJjEskc3avcv+FDkikjEdlNRRpGWIkEM8688kwYHzeGR49vAqjqJ18
TlDUiAwd05pJOqMwBXTGQoPYxcEZqOUfIMPtqEriZyJqhgoGsT0qSsyGUz97l++J
JLXUegHe1Eouy8PPn2PcTG/VthPeOzrIIeoGq6YPfmAF7CXU1pR1AM9s3fiQFRR3
uVTRsSVCExflQdtTDn1/dSArSDadXibaFSD8/CJDkkon6kfrHejfzrLhYmZ9DNQv
6PlUdJGOVvjzZSarVsXdc3d5xp895p9JtkVNqk+2W5j+Lyfhps3A7Bn9f8dqHolr
6ovxaEeXMFo4s9gU+h0CAwEAAaOCAYwwggGIMD0GA1UdEQQ2MDSCD3d3dy5wb3N0
YmFuay5kZYIUcmVsYXVuY2gucG9zdGJhbmsuZGWCC3Bvc3RiYW5rLmRlMAkGA1Ud
EwQCMAAwDgYDVR0PAQH/BAQDAgWgMB0GA1UdJQQWMBQGCCsGAQUFBwMBBggrBgEF
BQcDAjBmBgNVHSAEXzBdMFsGC2CGSAGG+EUBBxcGMEwwIwYIKwYBBQUHAgEWF2h0
dHBzOi8vZC5zeW1jYi5jb20vY3BzMCUGCCsGAQUFBwICMBkaF2h0dHBzOi8vZC5z
eW1jYi5jb20vcnBhMB8GA1UdIwQYMBaAFAFZq+fdOgtZpmRj1s8gB1fVkedqMCsG
A1UdHwQkMCIwIKAeoByGGmh0dHA6Ly9zci5zeW1jYi5jb20vc3IuY3JsMFcGCCsG
AQUFBwEBBEswSTAfBggrBgEFBQcwAYYTaHR0cDovL3NyLnN5bWNkLmNvbTAmBggr
BgEFBQcwAoYaaHR0cDovL3NyLnN5bWNiLmNvbS9zci5jcnQwDQYJKoZIhvcNAQEL
BQADggEBAGANEhdphor5xK/i+uUzFiDZI4CZ+JEhJCVScBKV488coZQv8iW8JRb3
8GZDrxHuJoYm66lfLSdVodAdrfaWsdF2SsRiyzzSk5el/+EHsWSs3LfTmTn4zsB2
2pUE71HdV4BBqxIoYAoR3gSeZkGvWF+GdtoSTFuhWylMr4uKfWFkPy5npSYLT/yj
7Vpy4/oLTQYqqPlCErKC6sxQvB/URSaitQrwfgt1Vc3j3N/9d3uLUV8p7HtPr0Z1
0RE4JoV0o8Jz8wUVuq7VYENObZnc0XQ3Z2KIL1CA2GRsU23BjZXpZ2jenNFLx3np
if2aIctDNgU5g4xhDxPxShtQABLElDo=
-----END CERTIFICATE-----')
  }
  let(:httpsig) {
    Ibanity::HttpSignature.new(certificate: cert,
                               certificate_id: ENV['IBANITY_CERTIFICATE'],
                               key: OpenSSL::PKey::RSA.new(2048),
                               method: 'GET',
                               uri: URI.parse('https://ibanity.com'),
                               query_params: {
                                   'param1' => 'value1',
                                   'param2' => 'value2'
                               },
                               headers: {
                                   'Authorization' => 'Basic am9obmRvZTppdHNtZQ==',
                                   'X-Meta-Header' => '0'
                               },
                               payload: "Some secret payload")
  }

  describe '#payload_digest' do
    context 'given a non-empty payload' do
      it 'returns a SHA-512 digest' do
        expect(httpsig.payload_digest.split('=')).to contain_exactly('SHA-512', 'D3lraaUEIy-pPUzOamoW7eIesz7Up3o80PWVzwn9qnhApk2R7IdNF4l-cQs7rjEkMA-wKOzvCmG6U6uNq_u-uQ')
      end
    end
  end

  describe '#signature_algorithm' do
    context 'given valid X509 certificate' do
      it 'returns string representation of signature algorithm' do
        expect(httpsig.signature_algorithm).to eq('rsa-sha256')
      end
    end
  end

  describe '#headers_to_sign' do
    context 'given a dict of headers' do
      it 'returns a list of HTTP header fields separated by a single space character' do
        expect(httpsig.headers_to_sign).to eq(["(request-target)", "host", "digest", "date", "authorization"])
      end
    end
  end

  describe '#request_target' do
    context 'given HTTP method and URI' do
      it 'return a representation string of the HTTP verb and the request URI' do
        expect(httpsig.request_target).to eq('GET /?param1=value1&param2=value2')
      end
    end
  end

  describe '#header_value' do
    context 'given the correct header field' do
      it 'returns the adequate header value' do
        expect(httpsig.header_value('(request-target)')).to eq('GET /?param1=value1&param2=value2')
        expect(httpsig.header_value('host')).to eq('ibanity.com')
        expect(httpsig.header_value('digest')).to eq('SHA-512=D3lraaUEIy-pPUzOamoW7eIesz7Up3o80PWVzwn9qnhApk2R7IdNF4l-cQs7rjEkMA-wKOzvCmG6U6uNq_u-uQ==')
        expect(!httpsig.header_value('date').nil?).to eq(true)
        expect(httpsig.header_value('x-meta-header')).to eq('0')
        expect(httpsig.header_value('unknown').nil?).to eq(true)
      end
    end
  end

  describe '#signing_string' do
    context 'given a set of HTTP headers to sign' do
      it 'returns headers to sign separated with line break' do
        expected = httpsig.signing_string
        expect(expected.split("\n").size).to eq(5)
      end
    end
  end

  describe '#base64_signature' do
    context 'given non-empty HTTP headers' do
      it 'returns base64 signature' do
        expect(!httpsig.base64_signature.nil?).to eq(true)
      end
    end
  end
end