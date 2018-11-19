#!/usr/bin/env python3

"""  """

__appname__ = 'regexs.py'
__author__ = 'Jacob Griffiths (jacob.griffiths18@imperial.ac.uk)'
__version__ = '0.0.1'

import re

#Create a string
my_string = "a given string"

#Find a space in the string
#re.search only finds first instance of a search
match = re.search(r'\s', my_string) #r = raw, \s = space
print(match) #tells you if a match was found (the object was created successfully)

#To see the match:
match.group()


#A different pattern
match = re.search(r'd', my_string) #d = numeric characters
print(match) #none found


#Using if to see if a pattern was found
MyStr = 'an example'
match = re.search(r'\w*\s', MyStr) 
# \w = any alphanumeric char
# * = zero or more times
if match:
    print('found a match:', match.group())
else:
    print('did not find a match')

#Some more examples
match = re.search(r'2' , "it takes 2 to tango")
match.group()

match = re.search(r'\d' , "it takes 2 to tango")
match.group()

match = re.search(r'\d.*' , "it takes 2 to tango")
match.group() # . = any char except linebreak

match = re.search(r'\s\w{1,3}\s', 'once upon a time')
match.group() # {1,3} = match proceeding at least 1 but not more than 3 times

match = re.search(r'\s\w*$', 'once upon a time')
match.group()

#Compacting syntax by appending .group() to the result

re.search(r'\w*\s\d.*\d', 'take 2 grams of H2O').group()

# ^ = match the start of a string
re.search(r'^\w*.*\s', 'once upon a time').group()

## Note, *, + and {} are all 'greedy'. They repeat
## previous regex token as many times as possible
## Use ? to make it non-greedy and terminate at first instance

re.search(r'^\w*.*?\s', 'once upon a time').group()

# Matching an HTML tag
# Greedy '+'
re.search(r'<.+>', 'This is a <EM>first</EM> test').group()
# Non-greedy '+'
re.search(r'<.+?>', 'This is a <EM>first</EM> test').group()

# \. used here to find a literal '.'
re.search(r'\d*\.?\d*','1432.75+60.22i').group()

re.search(r'[AGTC]+', 'the sequence ATTCGT').group()

re.search(r'\s+[A-Z]{1}\w+\s\w+', 'The bird-shit frog''s name is Theloderma asper').group()

#Looking for an email address in a string
MyStr = 'Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and ecological theory'
match = re.search(r"[\w\s]+,\s[\w\.@]+,\s[\w\s&]+",MyStr)
match.group() #[\w\s] ensures any combo of words chars and spaces is found

#Code falls down here because of the '-' in the email
MyStr = 'Samraat Pawar, s-pawar@imperial.ac.uk, Systems biology and ecological theory'
match = re.search(r"[\w\s]+,\s[\w\.@]+,\s[\w\s&]+",MyStr)
match.group()

#Make it more robust
match = re.search(r"[\w\s]+,\s[\w\.-]+@[\w\.-]+,\s[\w\s&]+",MyStr)
match.group()


### Grouping regex patterns ###
# You can group regex patterns into meaningful blocks using parentheses

MyStr = 'Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and ecological theory'
match = re.search(r"[\w\s]+,\s[\w\.-]+@[\w\.-]+,\s[\w\s&]+",MyStr)
match.group()

#Without grouping the regex:
match.group(0) #outputs everything

#Grouping with ():
match = re.search(r"([\w\s]+),\s([\w\.-]+@[\w\.-]+),\s([\w\s&]+)",MyStr)
if match:
    print(match.group(0))
    print(match.group(1))
    print(match.group(2))
    print(match.group(3))


### Find all matches ###
MyStr = "Samraat Pawar, s.pawar@imperial.ac.uk, Systems biology and ecological theory; Another academic, a-academic@imperial.ac.uk, Some other stuff thats equally boring; Yet another academic, y.a_academic@imperial.ac.uk, Some other stuff thats even more boring"

emails = re.findall(r'[\w\.-]+@[\w\.-]+', MyStr) 
for email in emails:
    print(email)

### Extracting text from webpages ###
import urllib3

conn = urllib3.PoolManager() # open a connection
r = conn.request('GET', 'https://www.imperial.ac.uk/silwood-park/academic-staff/') 
webpage_html = r.data #read in the webpage's contents

type(webpage_html) #imported as bytes, not strings

#Decode it (default decoding method applied here is utf-8)
My_Data  = webpage_html.decode()
print(My_Data)

#Extract just academic names
pattern = r"Dr\s+\w+\s+\w+"
regex = re.compile(pattern) # example use of re.compile(); you can also ignore case  with re.IGNORECASE 
for match in regex.finditer(My_Data): # example use of re.finditer()
    print(match.group())


#Replacing text
New_Data = re.sub(r'\t'," ", My_Data) # replace all tabs with a space
print(New_Data)




### Exercises###
#1
MyStr = "Samraat Pawar, s-pawar@imperial.ac.uk, Systems biology and ecological theory"
match = re.search(r"[\w\s]+,\s[\w\.-]+@[\w\.-]+,\s[\w\s&]+",MyStr)
match.group()

#This one allows for non-alphanumerics as well as punctation
match = re.search(r"[\D\s]+,\s[\w\.-]+@[\w\.-]+,\s[\w\s&]+",MyStr)
match.group()

#2 - translate these:
#Find 'abc' at the start of a string then,
#Find 'ab' one or more times,
#Followed by a space, a tab, and a numeric character
r'^abc[ab]+\s\t\d'

#Find a numeric char at the start of a string at least 
#once but not more than twice, followed by '/\',
#Do the same thing again, followed by a numeric character
#exactly 4 times at the end of the string
r'^\d{1,2}\/\d{1,2}\/\d{4}$'

#Find a space zero or more times followed by any 
#letter regardless of case one or more times
#and a space, one or more times, followed by zero or 
#more spaces
mystr = " ff "
match = re.search(r'\s*[a-zA-Z,\s]+\s*', mystr)

#3
mydate = "19941230"
match = re.search(r'[1-2]{1},[90]{1},\d{2},[0-1]{1},\d{1},[0-3]{1},\d{1}', mydate)
match.group()