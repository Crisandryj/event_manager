puts 'Event Manager Initialized!'
require 'csv'
fn = 'event_attendees.csv'

# p File.exist? "event_attendees.csv"

# contents = File.read(fn)
# puts contents

# lines = File.readlines(fn)

# row_index = 0
# lines.each_with_index do |line,index|
#     next if index == 0
#     columns = line.split(",")
#     p line
#     p columns
# end

contents = CSV.open(fn, headers: true, header_converters: :symbol)

contents.each do |row|
    name = row[:first_name]
    zipcode = row[:zipcode]
		if zipcode.nil?
			zipcode = '00000'
			elsif zipcode.length < 5
        zipcode = zipcode.rjust(5, '0')
      elsif zipcode.length > 5
        zipcode = zipcode[0..4]
      end
    p "#{name} #{zipcode}"
end 

