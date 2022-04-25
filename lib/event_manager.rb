puts 'Event Manager Initialized!'

fn = 'event_attendees.csv'

# p File.exist? "event_attendees.csv"

contents = File.read(fn)
# puts contents

lines = File.readlines(fn)

lines.each do |line|
    columns = line.split(",")
    p columns
end