clear all
clc;
load('lab6_8.mat');

yid=id.OutputData;
uid=id.InputData;
uval=val.InputData;
yval=val.OutputData;

na=8;
nb=8;
N=length(yid);
psi=zeros(N,na+nb);
ly=zeros(N,na);
lu=zeros(N,nb);

for i=1:N
    for j=1:na
        if(i-j)>0
            ly(i,j)=-yid(i-j);
        else
            ly(i,j)=0;
        end
    end
end

for i=1:N
    for j=1:nb
        if(i-j)>0
            lu(i,j)=uid(i-j);
        else
            lu(i,j)=0;
        end
    end
end

Yid=yid(:);
psi=[ly lu];
theta=psi\Yid;
yid_hat_pred=psi*theta;

yid_hat_sim=zeros(length(yid),1);

for i=1:length(yid)
    for j=1:na
        if(i-j>0)
            yid_hat_sim(i)=yid_hat_sim(i)-yid_hat_sim(i-j)*theta(j);
        else
            yid_hat_sim(i)=yid_hat_sim(i);
        end
    end
    for j=1:nb
        if(i-j>0)
            yid_hat_sim(i)=yid_hat_sim(i)+uid(i-j)*theta(j+na);
        else
            yid_hat_sim(i)=yid_hat_sim(i);
        end
    end
end

MSEid_sim=0;
for i=1:length(yid)
    MSEid_sim=MSEid_sim+(yid_hat_sim(i)-yid(i))^2;
end
MSEid_sim=MSEid_sim/length(yid);

MSEid_pred=0;
for i=1:length(yid)
    MSEid_pred=MSEid_pred+(yid_hat_pred(i)-yid(i))^2;
end
MSEid_pred=MSEid_pred/length(yid);

figure
plot(yid);hold on
plot(yid_hat_pred);
plot(yid_hat_sim);
legend('y_{id}','y_{id}pred','y_{id}sim');

for i=1:length(yval)
    for j=1:na
        if(i-j)>0
            ly(i,j)=-yval(i-j);
        else
            ly(i,j)=0;
        end
    end
end

for i=1:length(yval)
    for j=1:nb
        if(i-j)>0
            lu(i,j)=uval(i-j);
        else
            lu(i,j)=0;
        end
    end
end

psi_val=[ly lu];
yval_hat_pred=psi_val*theta;

yval_hat_sim=zeros(length(yval),1);

for i=1:length(yval)
    for j=1:na
        if(i-j>0)
            yval_hat_sim(i)=yval_hat_sim(i)-yval_hat_sim(i-j)*theta(j);
        else
            yval_hat_sim(i)=yval_hat_sim(i);
        end
    end
    for j=1:nb
        if(i-j>0)
            yval_hat_sim(i)=yval_hat_sim(i)+uval(i-j)*theta(j+na);
        else
            yval_hat_sim(i)=yval_hat_sim(i);
        end
    end
end

MSEval_sim=0;
for i=1:length(yval)
    MSEval_sim=MSEval_sim+(yval_hat_sim(i)-yval(i))^2;
end
MSEval_sim=MSEval_sim/length(yval);

MSEval_pred=0;
for i=1:length(yval)
    MSEval_pred=MSEval_pred+(yval_hat_pred(i)-yval(i))^2;
end
MSEval_pred=MSEval_pred/length(yval);

figure
plot(yval);hold on
plot(yval_hat_pred);
plot(yval_hat_sim);
legend('y_{val}','y_{val}pred','y_{val}sim');

