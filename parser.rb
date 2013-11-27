meta = {
"is_frontend" => "1",
"host1" => "127.0.0.2",
"tenant1" => "openshift2",
"timeout1" => "302",
"open_timeout1" => "302",
"keystone_host1" => "10.0.0.2",
"keystone_username1" => "user2",
"keystone_password1" => "passwd2",
"keystone_tenant1" => "lbms2",
"host2" => "127.0.0.3",
"tenant2" => "openshift3",
"timeout2" => "303",
"open_timeout2" => "303",
"keystone_host2" => "10.0.0.3",
"keystone_username2" => "user3",
"keystone_password2" => "passwd3",
"keystone_tenant2" => "lbms3",
"host3" => "127.0.0.4",
"tenant3" => "openshift4",
"timeout3" => "304",
"open_timeout3" => "304",
"keystone_host3" => "10.0.0.4",
"keystone_username3" => "user4",
"keystone_password3" => "passwd4",
"keystone_tenant3" => "lbms4"
}
#puts "meta: #{meta.inspect}"


meta2 = {
"is_frontend" => "1",
"host" => "127.0.0.2",
"tenant" => "openshift2",
"timeout" => "302",
"open_timeout" => "302",
"keystone_host" => "10.0.0.2",
"keystone_username" => "user2",
"keystone_password" => "passwd2",
"keystone_tenant" => "lbms2"
}

#newone = meta.select{ |key,value| key.match(/\d+/)}
multi = Hash.new { |h,k| h[k] = Hash.new(&h.default_proc) }

meta.select{ |key,value| key.match(/\d+/)}.each do |key,value|
  var_num = key.split(/(\d+)/)
  multi[var_num[1]][var_num[0]] = value
end
puts "multi: #{multi.inspect}"
multi.each { |k,v| puts k}
