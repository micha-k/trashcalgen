#!/usr/bin/env ruby

#
# Trash Calender Generator
# Michael Kessel (dev@michaelkessel.de)
#
# v1, 05.01.2014 


require 'optparse'
require 'icalendar'
require 'date'

include Icalendar

options = {}

optparse = OptionParser.new do |opts|
  opts.on('-i', '--input INPUTFILE', 'Filename of the input file') do |inputfile|
    options[:input] = inputfile
  end

  opts.on('-o', '--output OUTPUTFILE', 'Filename of the output file (ical)') do |outputfile|
    options[:output] = outputfile
  end
  
  opts.on('-r', '--remind HOURS', 'OPTIONAL: remind n hours before start') do |remind|
    options[:remind] = remind
  end

  opts.on('-h', '--help', 'Display this screen') do
    puts opts
    exit
  end
end

begin
  optparse.parse!
  mandatory = [:input, :output]                                         
  missing = mandatory.select{ |param| options[param].nil? }        
  if not missing.empty?                                            
    puts "Missing options: #{missing.join(', ')}"                  
    puts optparse                                                  
    exit                                                           
  end                                                              
rescue OptionParser::InvalidOption, OptionParser::MissingArgument      
  puts $!.to_s                                                          
  puts optparse                                                        
  exit                                                                   
end                                                                      

puts "Performing task with options: #{options.inspect}"

cal = Calendar.new
type=nil

data=File.open( options[:input] ).read
data.gsub!(/\r\n?/, "\n")

data.each_line do |line|
#  if(  ) {
#    
#  } elsif (.match(line)) {
#    
#  }
  
  pattern = /(\d\d)\.(\d\d)\.(\d\d\d\d)/
  result = line.match(pattern)
  
  if ( result )
    if type
      cal.event do
        dtstart       Date.new(result[3].to_i, result[2].to_i, result[1].to_i)
        dtend         Date.new(result[3].to_i, result[2].to_i, result[1].to_i)
        summary     type
        description type
        
        if options[:remind]
          alarm do
              action        "DISPLAY"
              summary       "Reminder"
              alarmtrigger = "-P0DT" + options[:remind] + "H0M0S"
              trigger       alarmtrigger
            end
        end
        
      end    
    end
    
  else
    pattern = /\[(.*)\]/
    result = line.match(pattern)
    
    if ( result )
      type = result[1]
    end
  end
  
end

cal.publish
cal_string = cal.to_ical

File.open(options[:output], 'w') {|f| f.write(cal_string) }