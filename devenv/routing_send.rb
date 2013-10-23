require 'rubygems'
require 'stomp'
c = Stomp::Client.new("routinginfo", "routinginfopasswd", "localhost", 6163, true)
puts "Sending #{ARGV[0]}"
c.send ('/topic/routinginfo', ARGV[0])

