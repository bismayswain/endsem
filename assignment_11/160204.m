###########################  Part-1
L=load("train.csv");
X_train=L(:,1);
Y_train=L(:,2);
n_train=size(X_train)(1,1);
X_train=[ones(n_train,1),X_train];

############################# Part-2

w=rand(2,1);

############################## Part-3

scatter(X_train(:,2),Y_train);
hold on;
plot(X_train(:,2),X_train*w);
#pause
print -dpdf "part_3.pdf";

#############################  Part-4

w_direct=inv((X_train')*X_train)*(X_train')*Y_train
hold off;
scatter(X_train(:,2),Y_train)
hold on;
plot(X_train(:,2),X_train*w_direct)
#pause
print -dpdf "part_4.pdf";

############################# Part-5
N=2;
eta=0.00000001;

hold off;

for(i=1:N),
  for(j=1:n_train),
    u=(X_train(j,:))';
    w=w-eta*(w'*u-Y_train(j,:))*u;
    if(mod(j,100)==0),
      hold on;
      plot(X_train(:,2),X_train*w);
    end,
  end,
end,

#pause
print -dpdf "part_5.pdf";
######################## Part-6
w
hold off;
scatter(X_train(:,2),Y_train);
hold on;
plot(X_train(:,2),X_train*w);
#pause
print -dpdf "part_6.pdf";


#########################  Part-7

M=load("test.csv");
X_test=M(:,1);
Y_test=M(:,2);
n_test=size(X_test)(1,1);
X_test=[ones(n_test,1),X_test];

y_pred1=X_test*w;
y_pred2=X_test*w_direct;


rms_err1=sqrt(mean((y_pred1-Y_test).^2))
rms_err2=sqrt(mean((y_pred2-Y_test).^2))


######################################
