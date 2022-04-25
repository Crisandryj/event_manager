puts 'Event Manager Initialized!'

p File.exist? "event_attendees.csv"

contents = File.read('event_attendees.csv')
puts contents