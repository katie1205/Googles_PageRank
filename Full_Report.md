# Google's Page Rank

It seems like spamming has been around since the dawn of the search engine! Over the years, google has developed algorithms to combat spamming. Spammers can be very resourceful, however, and have continually found clever workarounds. To build stronger defenses against spamming, it is essential to understand how these algorithms work.

## Spamming :pig: Techniques
The spammer's ultimate goal is to drive more traffic to their sites. Spammer's will employ clever tricks to show up in common search queries. For example, a spammer may put frequently searched key words, like "movie" or "sports", on their pages. Consequently, people whose searches contain the keywords are directed to the spammer's sites. 


## PAGE RANK: Google's First Defense :oncoming_police_car:
The idea behind Page Rank is that more "important" pages are more likely to receive in-links from other "important" pages. The "Page Rank" algorithm assigns a rank(score) to a given pages based on the ranks of the pages that link to it.

Basically, the algorithm works by estimating the likelihood that a *random* :surfer:s (ie, random person surfing the web) would end up at a page if they followed randomly chosen outlinks from their starting point.

A set of linked web pages can represented as a <i> directed graph </i>, where nodes representing the pages are linked together by arrows. The direction of the arrows distinguish in-links from out-links. A page points Below is an example of a directed graph that is <i>strongly connected</i>, meaning that you can get to any one web page/node via any other node.

![](https://github.com/katie1205/Google_Page_Rank/blob/master/strongly_connected.PNG)

The algorithm starts with an initial rank vector, <b>v<sub>0</sub></b>, where each element, <b>v<sub>i</sub></b>, is the probability that a random :surfer: would start at page i. That vector is then repeatedly multiplied by a *stoachastic matrix*, M, until the sequences approaches a limit, <b>v</b>. M is defined such that each elements, M<sub>ij</sub>, is the probability that the surfer will travel from page j to page i. 

The iterative process of multiplying by a vector by a matrix is called the power method, and here it is being used to estimate likelihood that random surfers will congregate at each page (ie, the rank vector). 

To demonstrate how to apply the algorithm, let's calculate the page ranks of pages A,B,C, and D in the the above graph. Since we don't have much information about the importance of the pages, let's assume that each page is an equally likely starting point for a random surfer. Later on, we will discuss the limitations of this assumption and how google addressed that with Topic-Sensitive Page Rank.

Since there are four pages, the probability (under the assumption of equal importance) that a random :surfer: will start on a given page is 1/4. We will store those probabilities in our starting vector, <b>v<sub>0</sub></b>:

| v_0 |
| --- |
| 1/4 |
| 1/4 |
| 1/4 |
| 1/4 |

Let the first, second, third, and fourth columns of "M" correspond to pages A,B,C, and D respectively. Let the first-fourth rows also correspond to A-D respectively. Then, construct M so that Mij is the probability that a surfer will travel from page j to page i as 1/(#number of outlinks) if j links to i, and zero otherwise:


|  A  |  B  |  C  |  D  |
| --- | --- | --- | --- |
|  0  | 1/2 |  0  | 1/3 |
|  0  |  0  | 1/2 | 1/3 |
|  0  | 1/2 |  0  | 1/3 |
|  1  |  0  | 1/2 | 1/2 | 


Then, the page ranks can be calculated by iterating through the matrix equation <b>v<sub>i-1</sub></b>=M<b>v<sub>i</sub></b> using a simple for loop. The for loop executes 1,000,000 iterations, but it's always a good idea to check the next iterations to ensure that a limit has actually been attained. To do that, multiply the output of the function by M a few more times. If the changes in the output for these iterations are insignificant, then you are in good shape. If not, then try increasing the 1,000,000 in the for loop. 


```{r}
#Function
Page_Rank<-function(M,v){
  for(i in c(1:1000000)){
    v<-M%*%v
  }
  print(v)
}
```

Now let's define our variables v=v<sub>0</sub> and the transition Matrix M for the example.

```{r}
(v_0<-c(rep(1/4,4))) #Vector v_0 
(M<-matrix(c(0,0,0,1,1/2,0,1/2,0,0,1/2,0,1/2,1/3,1/3,1/3,0),nrow=4,ncol=4)) #Transition Matrix, M
```

Finally, let's apply our page_rank function to M and v<sub>0</sub>
```{r}
Page_Rank(M,v)
```

### Problems With Page Rank
The intial page rank algorithm does not yield meaningful results for networks that are not strongly connected. Two examples of such networks are those that contain *dead ends* or *spider traps*, as described below.
+ :skull: *dead ends* are pages that have no out links. Consequently, the random walk goes nowhere, causing importance to “leak out”.
+ :spider: *spider traps* are a groups of pages for which all outlinks are within the group. Consequently, a random walk gets “stuck” in the trap and absorbs all of the importance.

Example of a one-node spider trap:

![](https://github.com/katie1205/Google_Page_Rank/blob/master/spider_Trap.PNG)

**Solutions**
Google addressed these issues by modifying the algorithm as follows:
+ removing :skull: ends: removes dead-ends recursively from a network before applying the page rank algorithm
+ teleporting :rocket:: allows the random :surfer: to have a small probability, 1 - &beta;, of teleporting to another page. In this case, the iterative equation becomes: 
&beta;M<b>v</b> + (1 - &beta;)<b>e</b>/n, where n is the number of pages in the network.

Here is an r function to estimate Page Rank with the teleportation modification:
```{r}
#Page_Rank_2
#Estimates modified Page Rank of a network of n pages, given:
#   + A probability "1-Beta" of teleporting
#   + An initial rank vector, v
#   + A stochastic n x n matrix M
Page_Rank_2<-function(M,v,Beta){
  n<-length(v)
  for (i in c(1:1000000)){
    v<-Beta*M%*%v + (1-Beta)*c(rep(1/n),n)
  }
}
```

### Topic Sensitive Page Rank
Teleportation was used to address the problematic assumption made by the initial Page Rank algorithm that all in-links are treated as equally important to the random :surfer:. Topic Sensitive Page Rank evaluates web pages according not just to popularity, but also to how closely related the page is are to a particular topic- eg “sports”. This allows queries to be answered based on interests of user. Topic Sensitive Page Rank works by modifying teleportation part of page rank equation to only teleport to relevant pages (the teleport set). 

### Trust Rank
Trust rank is a type of topic sensitive page rank in which the teleport set consists of "trusted" pages. 
