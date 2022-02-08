clear all
clc
load('lab10_1.mat');
na=3*n;
nb=3*n;
uid=id.u;
yid=id.y;
uval=val.u;
yval=val.y;
ts=val.ts;

N=length(yid);
theta=zeros(na+nb,N);
delta=100;

invPtrecut=1/delta*eye(na+nb);
epsilon=zeros(N,1);
W=zeros(na+nb,N);

for k=2:N
    ly=zeros(k,na);
    lu=zeros(k,nb);
    
    for i=1:na
        if(k-i)>0
            ly(k,i)=-yid(k-i);
        else ly(k,i)=0;
        end
    end
    
     for i=1:nb
        if(k-i)>0
            lu(k,i)=uid(k-i);
        else lu(k,i)=0;
        end
     end
    
     phi(k,:)=[ly(k,:) lu(k,:)];
     phi(k,:)=phi(k,:)';
     epsilon(k)=yid(k)-phi(k,:)*theta(:,k-1);
     invPprezent=invPtrecut-(invPtrecut*(phi(k,:)')*phi(k,:)*invPtrecut)/(1+phi(k,:)*invPtrecut*(phi(k,:)'));     
     
     W(:,k)=invPprezent*(phi(k,:)');
     theta(:,k)=theta(:,k-1)+W(:,k)*epsilon(k);
     invPtrecut=invPprezent;
end

for i=1:na
    an(i)=theta(i,N);
end

for i=na+1:na+nb
    bn(i-na)=theta(i,N);
end

A=[1 an];
B=[0 bn];

m_arx_rec=idpoly(A,B,[],[],[],0,ts);
compare(m_arx_rec,val);

