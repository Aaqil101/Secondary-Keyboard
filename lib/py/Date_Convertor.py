import datetime
import pyperclip

def master():
    # Print the formatted string
    date_string = input("Enter Date/Dates: ")
    if " - " in date_string:
        formatted_two_strings = convert_two_dates(date_string)
        print(formatted_two_strings)
    else:
        formatted_one_string = covert_one_date(date_string)
        print(formatted_one_string)

def convert_two_dates(two_date_string):
    # Split the string into two dates
    start_date, end_date = two_date_string.split(" - ")

    # Convert each date to datetime object
    start_date = datetime.datetime.strptime(start_date, "%b %d, %Y")
    end_date = datetime.datetime.strptime(end_date, "%b %d, %Y")
  
    # Format the dates in YYYY-MM-DD format
    # Add "FROM" and "TO"
    formatted_two_strings = f"FROM {start_date.strftime('%Y-%m-%d')} TO {end_date.strftime('%Y-%m-%d')}"

    # Copy the formatted string to the clipboard
    pyperclip.copy(formatted_two_strings)

    return formatted_two_strings

def covert_one_date(one_date_string):
    # Convert the date to datetime object
    date = datetime.datetime.strptime(one_date_string, "%b %d, %Y")

    # Format the date in YYYY-MM-DD format
    # Add "FROM", "TO" and "TODAY"
    formatted_one_string = f"FROM {date.strftime('%Y-%m-%d')} TO TODAY"

    # Copy the formatted string to the clipboard
    pyperclip.copy(formatted_one_string)

    return formatted_one_string

master()