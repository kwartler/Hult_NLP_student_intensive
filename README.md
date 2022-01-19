# Hult_NLP_student_intensive
4 day Hult Student NLP Repository

## Course Book
If wanting to have a reference book during or after the course, the lessons support the examples in Ted Kwartler's book [Text Mining in Practice with R](https://www.amazon.com/Text-Mining-Practice-Ted-Kwartler/dp/1119282012)

## Classes & Assignment Due dates

|Class      |Covered in Class.                        |Due 5pm EST           |
|-----------|-----------------------------------------|----------------------|
|Jan 20 Thur|What is NLP, git, r syntax, r-studio     |                      |
|Jan 21 Fri |String Manipulation, DTM/TDM/WFM, Visuals|                      |
|Jan 22 Sat |Supervised & Unsupervised Methods        |EDA Visuals Assignment|
|Jan 23 Sun |API, web scraping, ESG & Ethics          |                      |
|Jan 31 Mon |NA                                       |CASE: Press Releases  |

## Working with R
If you are new to R, please take an online course to get familarity prior to the first session.  We will still cover R basics but students have been aided by spending a few hours taking a free online course at [DataQuest](www.dataquest.com) or [DataCamp](www.datacamp.com).  The code below should be run in the console to install packages needed for the semester.

## Lesson Structure
Each day's lesson is contained in the **lesson** folder.  Each individual lesson folder will contain the following files and folders.
 
* slides - A copy of the presentation covered in the recording.  Provided because some students print the slides and take notes.
* `data` sub folder - contains the data we will work through together
* `scripts` - commented scripts to demonstrate the lesson's concepts

## Environment Setup

* You *must* install R, R-Studio & Git locally on your laptop or if you require you can work from a server instance with all software. [www.rstudio.cloud](www.rstudio.cloud) is another option but the free tier has significant time limitations. Part of day 1 will be devoted to ensuring people's instances work correctly.

## Please install the following packages with this R code.
```
# Individually you can use 
# install.packages('packageName') such as below:
install.packages('ggplot2')

# or 
install.packages('pacman')
pacman::p_load(caret,clue,cluster,dplyr,
e1071,echarts4r,fst,ggalt,
 ggplot2,ggthemes,ggwordcloud,glmnet,
 hunspell,kmed,lda,LDAvis,leaflet,lexicon,
 lsa,mapproj,maps,mgsub,MLmetrics,pbapply,
 pdftools,plotrix,plyr,pROC,qdap,
 radarchart,rbokeh,RColorBrewer,RCurl, 
 readxl,reshape2,RTextTools,rvest,sentimentr, 
 skmeans,spelling,stringi,stringr,text2vec,
 tidytext,tm,treemap,viridisLite,vtreat,
 wordcloud,wordcloud2,yardstick)

# Additionally we will need this package from a different repo;
# try this first, but it may timeout since their server is old/slow?
install.packages("http://datacube.wu.ac.at/src/contrib/openNLPmodels.en_1.5-1.tar.gz",
                repos=NULL,
                type="source")

# alternatively, you can download the `openNLPmodels.en_1.5-1.tar.gz` file from 
# https://datacube.wu.ac.at/src/contrib/ then use the following code to install it 
# from a local file; be sure to change the path to your own download location
install.packages("~/Downloads/openNLPmodels.en_1.5-1.tar.gz", repos = NULL, type = "source")

```

## Installing rJava (needed for Qdap) on MAC!
For most students these two links have helped them install java, and then make sure R/Rstudio can find it when loading `qdap`.  **Keep in mind, you don't have to install qdap, to earn a good grade** This is primarily for the use of some functions including `polarity()`.

* [link1](https://zhiyzuo.github.io/installation-rJava/)
* [link2](https://stackoverflow.com/questions/63830621/installing-rjava-on-macos-catalina-10-15-6)

Once java is installed this command *from terminal* often resolves the issue:

```
sudo R CMD javareconf
```

If this causes hardship, don't worry! Its only a small bit of our overall learning.
If you encounter any errors don't worry we will find time to work through them.  The `qdap` library is usually the trickiest because it requires Java and `rJava` and does not work on Mac.  So if you get any errors, try removing that from the code below and rerunning.  This will take **a long time** if you don't already have the packages, so please run prior to class, and at a time you don't need your computer ie *at night*.




