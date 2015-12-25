'''
This program takes a freecodecamp.com URL and parses the HTML code in the
editor. It then copies that into a file on my system and pushes that to
my FreeCodeCamp github repository at https://github.com/crisron/FreeCodeCamp
'''

import urllib2
import sys
import os
import subprocess
from bs4 import BeautifulSoup

def main():

    if len( sys.argv ) != 2:
        print "Incorrect number of arguments\n"
        print "Usage: python CopyFromFCC.py <URL>\nURL - a freecodecamp.com URL"
        return

    if "www.freecodecamp.com" not in sys.argv[ 1 ]:
        print "Error: URL does not belong to freecodecamp domain\n"
        print "Usage: python CopyFromFCC.py <URL>\nURL - a freecodecamp.com URL"
        return

    if "challenges" not in sys.argv[ 1 ]:
        print "Error: The URL does not belong to a challenge page"
        print "URL should have this format: www.freecodecamp.com/challenges/XYZ"
        return

    URL = sys.argv[ 1 ]

    page = urllib2.urlopen( URL )
    content = page.read()

    # The editor code is embedded inside a javascript
    # variable named challengeSeed
    challengeSeedLoc = content.find( 'challengeSeed' )
    contentStartLoc = content.find( '"', challengeSeedLoc )
    contentEndLoc = content.find( '"];', contentStartLoc )
    HTML = content[ contentStartLoc + 1 : contentEndLoc ]

    # Some extraneous characters are present in the
    # above HTML. Deleting them.
    deleteChars = [ '","', '\\', "'", "_" ]
    for char in deleteChars:
        HTML = HTML.replace( char, "" )

    # Using lxml parser
    soup = BeautifulSoup( HTML, 'lxml' )
    
    # Indenting the code
    prettyHTML = soup.prettify()

    # My local clone of FreeCodeCamp repo on github
    fccDir = '/Users/saurabh/FreeCodeCamp/'

    # Getting all the filenames in the repo
    files = [ f for f in os.listdir( fccDir ) \
            if os.path.isfile( os.path.join( fccDir, f ) ) ]

    greatest = 0
    # Files in my repo are named as 1.html, 2.html etc.
    # This loop finds the filename with the greatest number
    for fileName in files:
        fileWithoutExt = fileName.split( "." )[ 0 ]
        fileExt = fileName.split( "." )[ 1 ]

        # This check is required for hidden files like
        # .gitignore and files with extensions other
        # than html like README.md
        if fileExt == 'html':
            # Converting the filename to integer
            fileNameInt = int( fileWithoutExt )
            if fileNameInt > greatest:
                greatest = fileNameInt

    # The new filename should be one greater than
    # the currently greatest file
    newFileName = str( greatest + 1 ) + '.html'
    
    # Getting the absolute file path
    htmlFile = os.path.join( fccDir, newFileName ) 

    # Writing the formatted HTML into the page
    open( htmlFile, 'w' ).write( prettyHTML )

    class cd:
        '''Context manager for changing the current working directory'''
        def __init__(self, newPath):
            self.newPath = os.path.expanduser(newPath)

        def __enter__(self):
            self.savedPath = os.getcwd()
            os.chdir(self.newPath)

        def __exit__(self, etype, value, traceback):
            os.chdir(self.savedPath)

    with cd( fccDir ):
        soup = BeautifulSoup( content, 'lxml' )

        # Getting the HTML page title
        pageTitle = soup.title.string
        words = pageTitle.split( ' ' )

        # The page titles are in this format:
        # Waypoint: X Y Z | Free Code Camp
        # Zipline: X Y Z | Free Code Camp
        # Extracting the X Y Z part for
        # the commit message

        # Getting away with Waypoint: etc
        words = words[ 1: ]

        # title += will not work without this
        commitMsg = ''
        for word in words:
            # We don't want to go beyond | symbol
            if word == '|':
                break
            commitMsg += " " + word

        # Getting rid of the space character at the
        # start of the commit message
        commitMsg = commitMsg[ 1: ]

        # Command to add the new file to the list
        # of files to be committed
        gitAdd = [ 'git', 'add', htmlFile ]
        subprocess.call( gitAdd )

        # We need the commit msg to be like
        # "Commit Message" instead of Commit Message
        # commitMsgInQuotes = '"' + commitMsg + '"'
        gitCommit = [ 'git', 'commit', '-m', commitMsg ]
        subprocess.call( gitCommit )

        gitPush = [ 'git', 'push', 'origin', 'master' ]
        subprocess.call( gitPush )

if __name__ == '__main__':
    main()
