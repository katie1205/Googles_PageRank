# Google_Page_Rank

# Problem
It seems like spamming has been around since the dawn of the search engine! Over the years, google has developed algorithms to combat spamming. Spammers can be very resourceful, however, and have continually found clever workarounds. To build stronger defenses against spamming, it is essential to understand how these algorithms work.

## Spamming Techniques
The spammer's goal is to drive traffic to their sites by making them show up on search queries. Spammers put frequently or commonly searched keywords such as "movie" or "sports" on their pages. These keywords are usually the same color as the page’s background, rendering them invisible. Consequently, people whose searches contain the keywords are directed to the spammer's sites. Google's first defense against spamming was "Page Rank".

### PAGE RANK: Google's First Defense
The idea behind Page Rank is that more "important" pages would have more in-links from other "important" pages. The "Page Rank" algorithm assigns a rank(score) to a given pages based on the ranks of the pages that link to it. 

Basically, the algorithm works by simulating random pages as starting points for webs surfers (called "random surfers”) and then calculating where the surfers would likely congregate if they followed randomly chosen outlinks from the starting point.
A subset of the web can be represented as a directed graph of web pages, where pages are linked together by arrows. The direction of the arrows distinguish in-links from out-links. 
