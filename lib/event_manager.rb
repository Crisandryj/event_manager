require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'

	

def clean_zipcode(zipcode)

zipcode.to_s.rjust(5,"0")[0..4]

end 

def legislators_by_zip(zip)
	civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
	civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

	begin
	legislators = civic_info.representative_info_by_address(
		address: zip, 
		levels: 'country', 
		roles: ['legislatorUpperBody', 'legislatorLowerBody']).officials
	rescue
		"Please find on website" 
	end
end 

contents = CSV.open('event_attendees.csv', headers: true, header_converters: :symbol)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

contents.each do |row|
	name = row[:first_name]
	zipcode = clean_zipcode(row [:zipcode])

	legislators = legislators_by_zip(zipcode)

	form_letter = erb_template.result(binding)
  puts form_letter
end 
