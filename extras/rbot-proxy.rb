# (c) 2013 Matthias Hecker

require 'socket'
require 'drb'

botuser = 'rbotnotify'
botpassword = 'rbotpassword'
rbot_url = 'druby://127.0.0.1:7268'

socket = UDPSocket.new
socket.bind('', 7272)
loop do
  data = socket.recvfrom(1024)
  puts "#{Time.now} - #{data.inspect}"
  message = data.first
  from = data.last.last
  parts = message.split('|')
  password = parts.shift
  channel = parts.shift
  message = parts.join('|').strip
  next if not message or message.empty?
  if password == 'rbot'
    puts "Sending #{message} to #{channel}"
    rbot = DRbObject.new_with_uri(rbot_url)
    id = rbot.delegate(nil, "remote login #{botuser} #{botpassword}")[:return]
    puts "id is: #{id}"
    rbot.delegate(id, "dispatch say #{channel} #{message}")
  end
end

# Usage with nc: echo "<password>|#test|." | nc -u <host> 7272
