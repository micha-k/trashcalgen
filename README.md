# trashcalgen
===========

Generate .ics files with full day events (e.g. a trash calender) from a given input list


## Dependencies
The following ruby packages (installed via gems) are required for the correct function of this script.
* icalendar

## Usage
Usage: trashcalgen [options]
    -i, --input INPUTFILE            Filename of the input file
    -o, --output OUTPUTFILE          Filename of the output file (ical)
    -r, --remind HOURS               OPTIONAL: remind n hours before start
    -h, --help                       Display this screen

## Input File Format
The input file will be parsed after two string patterns:
* [sectionname] - this introduces a new section. The sections name will be the title of any calender event for the upcoming dates UNTIL a new section is started. 
* Date in format \d\d.\d\d.\d\d\d\d (european notation, sorry ;-) ) - for each of this dates a new event will be created. If no section is introducted before a date, no event is created.

How an input file can look like:

; Maybe some comments
; since they will be ignored

[regular trash]
09.01.2014
23.01.2014
06.02.2014

[plastic trash]
29.01.2014
26.02.2014
01.04.2014


## Example
Create trash calender from input file
./trashcalgen.rb -i trashdates_ade14.txt -o trashcal.ics

Generate trash calender and remind me the day before at 2pm
./trashcalgen.rb -i trashdates_ade14.txt -o trashcal.ics -r 10
