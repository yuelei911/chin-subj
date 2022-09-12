####################  Random selection for article  ####################
########################################################################

#read data for every magazine
journal1<-read.table("Acta Psychologica Sinica 2008.txt")  #Acta Psychologica Sinica
journal1<-t(journal1)
journal2<-read.table("Journal of Psychological Science 2008.txt")  #Journal of Psychological Science
journal2<-t(journal2)
journal3<-read.table("Chinese Journal of Clinical Psychology 2008.txt")  #Chinese Journal of Clinical Psychology
journal3<-t(journal3)
journal4<-read.table("Psychological Development and Education 2008.txt")  #Psychological Development and Education
journal4<-t(journal4)
journal5<-read.table("Studies of Psychology and Behavior 2008.txt")  #Studies of Psychology and Behavior
journal5<-t(journal5)

#The number of articles drawn from each magazine
num<-c(39,107,64,24,16)

#set random seeds
set.seed(1000)

#Each magazine is randomly selected 10 times
#five magazines
rand1<-rand2<-rand3<-rand4<-rand5<-NULL
for (m in 1:5) {
  #base on "m", call the journal number of the corresponding variable
  jour_num<-paste("journal",m,sep="")
  
  #generate the corresponding size of the null matrix
  rand<-matrix(,10,num[m])
  
  #10 random selections
  for (n in 1:10) {
    #save the results
    rand[n,]<-sample(get(jour_num),size=num[m])
  }
  
  #assign random results to rand1-rand5
  assign(paste("rand",m,sep=""),rand)
}


#randomly select one results from 10 random selections
chioce1=chioce2=chioce3=chioce4=chioce5=NULL
for (i in 1:5) {
  #generate the corresponding size of the null matrix
  a=matrix(,1,num[i])
  
  #save the results
  a=get(paste("rand",i,sep=""))[sample(c(1:10),size=1),]
  
  #assign the results to chioce1-chioce5
  assign(paste("chioce",i,sep=""),a)
}


#export results
#merge all numbers
chioce=c(chioce1,chioce2,chioce3,chioce4,chioce5)

#sort numbers
chioce=sort(chioce)

#export the final random result
write.table(chioce,"sample 2008.txt",row.names=F,col.names=F)

