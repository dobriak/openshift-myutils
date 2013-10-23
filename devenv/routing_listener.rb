require 'rubygems'
require 'stomp'
c = Stomp::Client.new("routinginfo", "routinginfopasswd", "localhost", 6163, true)
c.subscribe('/topic/routinginfo') do |msg|
  puts
  puts msg
  c.acknowledge msg
end
c.join
