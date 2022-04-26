puts 'Event Manager Initialized!'

fn = 'event_attendees.csv'

# p File.exist? "event_attendees.csv"

contents = File.read(fn)
# puts contents

lines = File.readlines(fn)

lines.each do |line|
    next if line == " ,RegDate,first_Name,last_Name,Email_Address,HomePhone,Street,City,State,Zipcode\n"
    columns = line.split(",")
    p columns[2]
end