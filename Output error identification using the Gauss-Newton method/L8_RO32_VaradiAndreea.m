clear all
load('lab8_2.mat');
uid=id.InputData;
yid=id.OutputData;
uval=val.InputData;
yval=val.OutputData;
ts=id.Ts;

N=length(yid);
alpha=0.1;
lmax=135;
theta=[1;1];
l=1;

while(l<lmax)
    
    f=theta(1,l);
    b=theta(2,l);
    epsilon(1)=0;
    
    for k=2:N
        epsilon(k)=yid(k)+f*yid(k-1)-b*uid(k-1)-f*epsilon(k-1);
    end
    
    df=[];
    db=[];
    df(1)=0;
    db(1)=0;
    
    for k=2:N
        df(k)=yid(k-1)-epsilon(k-1)-f*df(k-1);
        db(k)=-uid(k-1)-f*db(k-1);
    end
    
    depsilon=[df;db];
    
    dv1=0;
    dv2=0;
    
    for k=1:N
        dv1=dv1+depsilon(1,k)*epsilon(k);
        dv2=dv2+depsilon(2,k)*epsilon(k);
    end
    
    dv=2/N*[dv1;dv2];
    
    H=2/N*(depsilon*(depsilon'));
    
    theta(:,l+1)=theta(:,l)-alpha*inv(H)*dv;
    
    l=l+1;
end

F=[1 f];
B=[0 b];
m_oe=idpoly(1,B,1,1,F,0,ts);
compare(m_oe,val);