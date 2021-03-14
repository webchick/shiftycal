#!/bin/bash

# Standard boilerplate stuff,
echo "BEGIN:VCALENDAR"
echo "VERSION:2.0"
# Credit where it is due. ;)
echo "PRODID:-//Webchick Inc//Webchick’s Crappy Bash Script 1.0//EN"

# Loop through the CSV file containing shifts.
while IFS=, read -r date type;
do
  # Timezone value.
  tz="America/Vancouver"
  # Generate a unique ID.
  uid=$(uuidgen)
  # Get the current date/time in UTC.
  dtstamp=$(date -u "+%Y%m%dT%H%M%SZ")  
  # Turn 2021-01-16 into 20210116,
  date=${date//-/}

  # Begin event definition.
  echo "BEGIN:VEVENT"
  echo "UID:$uid"
  echo "DTSTAMP:$dtstamp"

  # Day shifts begin at 8am and end at 6pm.
  if [[ $type == *"Day"* ]]
  then
    echo "SUMMARY:Day Shift"
    echo "DTSTART;TZID=${tz}:${date}T080000"
    echo "DTEND;TZID=${tz}:${date}T180000"
  fi

  # Evening shifts begin at 5:30pm and end at 11:30pm.
  if [[ $type == *"Eve"* ]]
  then
    echo "SUMMARY:Evening Shift"
    echo "DTSTART;TZID=${tz}:${date}T173000"
    echo "DTEND;TZID=${tz}:${date}T233000"
  fi

  # Aaaaand, repeat on an odd cadence.
  echo "RRULE:FREQ=WEEKLY;INTERVAL=8;UNTIL=20211231"
  echo "END:VEVENT"
done < shifts.csv

echo "END:VCALENDAR"
