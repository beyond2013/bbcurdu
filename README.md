File bbc.rb contains code to scrap urdu news articles from bbc urdu website. The file can be executed on command line:

```bash
ruby bbc.rb
```

1. When executed, it asks for url of the article. The url is passed to the function **gather\_url** which collects all urls pointing to related articles and returns an array of articles. 

2. Function **scrap** takes array of articles returned by **gather\_url** and loops over the array of articles, collecting the contents of each article one by one and calling **writeToFile** for writing each article to file system

3. The progress of scrapping is displayed in the terminal by a message _contents written to file data/path/to/file"_

4. Ruby code expects a data folder in the same directory where bbc.rb is placed.
File names consist of last part of the url of the form xxxxx-0000000, where xxxx is one of the words (regional, sports, science, pakistan, entertainment) and 000 are digits.

The script successfully scraps articles most of the time(80-90%) it sometimes throws an exception 

> Failed to open TCP connection to www.bbc.com (getaddrinfo: Name or service not known) SocketError
