require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'time'

	

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

def create_form(id,form)
  Dir.mkdir("output") unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename,'w') do |file| 
    file.puts form
  end 
end 

def clean_phone_number(phone_num)
  if phone_num.length < 10
    phone_num = "0000000000"
  elsif phone_num.length == 10
    phone_num = phone_num
  elsif phone_num.length == 11 && phone_num[0] == 1
    phone_num = phone_num[1..10]
  elsif phone_num.length == 11 && phone_num[0] != 1
    phone_num = "0000000000"
  elsif phone_num.length > 11
    phone_num = "0000000000"
  end 
  phone_num
end 



contents = CSV.open('event_attendees.csv', headers: true, header_converters: :symbol)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

contents.each do |row|
	name = row[:first_name]
	zipcode = clean_zipcode(row [:zipcode])
	id = row[0]
  regtime = row[:regdate]
  begin
  p Time.parse(regtime).strftime("%k:%M") 
  p "Wedenesday" if Time.parse(regtime).wday  == 4
  rescue
    "visit website"
  end 

  phone_num = row[:homephone].gsub(/[^0-9]/, '')  

  phone_num_list = clean_phone_number(phone_num)

  phone_num_list

	legislators = legislators_by_zip(zipcode)

	form_letter = erb_template.result(binding)

  create_form(id,form_letter)


end 
