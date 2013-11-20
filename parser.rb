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
puts "meta: #{meta.inspect}"

newone = meta.select{ |key,value| key.match(/\d+/)}
#puts newone.inspect
newtwo = Hash.new({})
zz = {}
newone.each do |key,value|
  #puts "#{key},#{value}"
  var_num = key.split(/(\d+)/)
  #puts var_num.inspect
  newthree = {var_num[0] => value }
  #puts zz.inspect
  newtwo[var_num[1].to_s].merge!(newthree)
end
puts newtwo.inspect
