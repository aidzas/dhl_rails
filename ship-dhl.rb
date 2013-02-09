
require "net/https"
require "uri"

uri = URI.parse("https://xmlpitest-ea.dhl.com/XMLShippingServlet")
file = "request/request.xml"

post_body = File.read(file)

http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Post.new(uri.request_uri)
request.body = post_body
request["Content-Type"] = "text/xml"

response = http.request(request)
puts response


time = Time.new
filename = time.strftime "%Y-%m-%d-%H-%M-%S"

begin
  file = File.open("./response/"+filename+".xml", "w")
  file.write(response.body) 
rescue IOError => e
  #some error occur, dir not writable etc.
ensure
  file.close unless file == nil
end
