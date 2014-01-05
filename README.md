# trashcalgen
Generate .ics files with full day events (e.g. a trash calender) from a given input list


## Dependencies
The following ruby packages (installed via gems) are required for the correct function of this script.
* icalendar

## Usage
Usage: trashcalgen [options]<br />
    -i, --input INPUTFILE            Filename of the input file<br />
    -o, --output OUTPUTFILE          Filename of the output file (ical)<br />
    -r, --remind HOURS               OPTIONAL: remind n hours before start<br />
    -h, --help                       Display this screen

## Input File Format
The input file will be parsed after two string patterns:
* [sectionname] - this introduces a new section. The sections name will be the title of any calender event for the upcoming dates UNTIL a new section is started. 
* Date in format \d\d.\d\d.\d\d\d\d (european notation, sorry ;-) ) - for each of this dates a new event will be created. If no section is introducted before a date, no event is created.
<br />
How an input file can look like:
<br />
; Maybe some comments<br />
; since they will be ignored<br />

[regular trash]<br />
09.01.2014<br />
23.01.2014<br />
06.02.2014<br />

[plastic trash]<br />
29.01.2014<br />
26.02.2014<br />
01.04.2014<br />


## Example
Create trash calender from input file<br />
./trashcalgen.rb -i trashdates_ade14.txt -o trashcal.ics

Generate trash calender and remind me the day before at 2pm<br />
./trashcalgen.rb -i trashdates_ade14.txt -o trashcal.ics -r 10
