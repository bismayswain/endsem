#########################    Part-1



num_samples <- 50000
data <- rexp(num_samples, 0.2)
#print(data)
value <- list()
for (i in 1: 500)
{
#	print(data[10:20])	
	start=i*100-99
	end=i*100
	value[[i]] = c(data[start:end])
	#print(value[[i]])
}
#######################################     Part-2
for (i in 1:500)
{
	#str(value[[i]])
	#print(value[[i]])
}
for (j in 1:5)
{
	pdata <- rep(0, 20);

	for(i in 1:100)
	{
	    val=round(value[[j]][i], 0)
	    #print(val)
	    if(val <= 20)
	    {
	           pdata[val] = pdata[val] + 1/ 100; 
	    }
	}
	xcols <- c(0:19)

	#str(pdata)
	#str(xcols)

	plot(xcols, pdata, "l", xlab="X", ylab="f(X)")
	####################################    Part-3
	cdata <- rep(0, 20)

	cdata[1] <- pdata[1]

	for(i in 2:20){
		    cdata[i] = cdata[i-1] + pdata[i]
	}

	plot(xcols, cdata, "o", col="blue", xlab="X", ylab="F(X)");


	print(paste(" sample ",j," #########################"))
	print(mean(value[[j]]))
	print(sd(value[[j]]))

}
######################################   Part-4
mean_sample <- rep(0,500)
dev_sample <- rep(0,500)
for (i in 1:500)
{
	mean_sample[i] <- mean(value[[i]])
	dev_sample[i] <-sd(value[[i]])
}

tab <- table(round(data))

#str(tab)
plot(tab, "h", xlab="Value of mean of samples", ylab="Frequency")


pdata <- rep(0, 30);

for(i in 1:500){
	    val=round(mean_sample[i], 0);
    if(val <= 30){
	           pdata[val] = pdata[val] + 1/ 500; 
        }
}

xcols <- c(0:29)

#str(pdata)
#str(xcols)

plot(xcols, pdata, "l", xlab="X", ylab="f(X)")

cdata <- rep(0, 30)

cdata[1] <- pdata[1]

for(i in 2:30){
	    cdata[i] = cdata[i-1] + pdata[i]
}

plot(xcols, cdata, "o", col="blue", xlab="X", ylab="F(X)");



############################ Part-5

mean_overall <- mean(mean_sample)
dev_overall <- sd(mean_sample)


############################    Part-6

print(mean_overall)
print(dev_overall)











