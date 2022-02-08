clear all
load('lab9_2.mat');
na=n;
nb=n;
uid=id.u;
yid=id.y;
uval=val.u;
yval=val.y;
ts=val.ts;
N=length(yid);

%model ARX
model_arx=arx(id,[na nb 0]);
y=sim(model_arx,id);
yhat_arx=y.OutputData;

%model vi var simple
lunanb=zeros(N,na);
lunb=zeros(N,nb);
Z=zeros(N,na+nb);

for k=1:N
    for i=1:na
        if(k-na-i>0)
            lunanb(k,i)=uid(k-nb-i);
        else
            lunanb(k,i)=0;
        end
    end
    for i=1:nb
        if(k-nb>0)
            lunb(k,i)=uid(k-i);
        else
            lunb(k,i)=0;
        end
    end
    Z(k,:)=[lunanb(k,:) lunb(k,:)];
end

phi=zeros(N,na+nb);
ly=zeros(N,na);
lu=zeros(N,nb);

for i=1:N
    for j=1:na
        if(i-j)>0
            ly(i,j)=-yid(i-j);
        else ly(i,j)=0;
        end
    end
end

for i=1:N
    for j=1:nb
        if(i-j)>0
            lu(i,j)=uid(i-j);
        else lu(i,j)=0;
        end
    end
end
phi=[ly lu];

Z=Z';
phi_tilda=Z*phi*1/N;
Yid=yid(:);
Y_tilda=Z*Yid*1/N;
theta_hat=phi_tilda\Y_tilda;
modelVI_varSimple=idpoly([1 theta_hat(1) theta_hat(2)],[0 theta_hat(3) theta_hat(4)],[],[],[],0,ts);

%model vi var ARX
ly=zeros(N,na);
lunb2=zeros(N,nb);
Z2=zeros(N,na+nb);

for k=1:N
    for i=1:na
        if(k-na-i>0)
            ly(k,i)=yhat_arx(k-i);
        else
            ly(k,i)=0;
        end
    end
    for i=1:nb
        if(k-nb>0)
            lunb2(k,i)=uid(k-i);
        else
            lunb2(k,i)=0;
        end
    end
    Z2(k,:)=[-ly(k,:) lunb2(k,:)];
end

Z2=Z2';
phi_tilda2=Z2*phi*1/N;
Y_tilda2=Z2*Yid*1/N;
theta_hat2=phi_tilda2\Y_tilda2;
modelVI_varARX=idpoly([1 theta_hat2(1) theta_hat2(2)],[0 theta_hat2(3) theta_hat2(4)],[],[],[],0,ts);

%comparare modele obtinute
compare(val,modelVI_varSimple,modelVI_varARX,model_arx);