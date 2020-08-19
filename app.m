%Shivam Handa%
%16ME02021%
%Term Project (MSSL 2)- Shear Force Bending Moment diagram%
%School of Mechanical Sciences%
%IIT Bhubaneswar%



t=input("Enter condition hinged=0 and cantilever=1");

if (t==0) %Hinged%

L=input("Enter the length of beam (in meters)");
L=round(L,4,'significant');
aLoc=input("Enter the location of first support (from left end)");
bLoc=input("Enter the location of second support (from left end)");

np=input("Enter the number of point loads");
nv=input("Enter the number of UDL");
nm=input("Enter the number of External Moment");
pLoad=[];  %point load matrix%
pLoc=[];   %point load location matrix&
%z is a dummy variable%
for i=1:np
    z=input("Enter Point load (in Newtons) "+i);
    pLoad=[pLoad,z];
    z=input("Enter location of Point load (from left end)"+i);
    z=round(z,4,'significant');
    pLoc=[pLoc,z];
end
uLoad=[]; %UD load matrix%
uLoc=[];  %UD load location matrix%
uSpan=[]; %UD load span matrix%
for i=1:nv
    z=input("Enter UD load (in N/m)"+i);
    uLoad=[uLoad,z];
    z=input("Enter location of UD load (from left end)"+i);
    z=round(z,4,'significant');
    uLoc=[uLoc,z];
    z=input("Enter the span of UD load"+i);
    z=round(z,4,'significant');
    uSpan=[uSpan,z];
end
mLoad=[];
mLoc=[];
for i=1:nm
    z=input("Enter the External Moment (in Newton meters)");
    mLoad=[mLoad,z];
    z=input("Enter the location of Moment");
    mLoc=[mLoc,z];
end
sum=0;
Ra=0;
Rb=0;
for i=1:np
    Rb=Rb+(pLoc(i)-aLoc)*pLoad(i);
    sum=sum+pLoad(i);
end
%Loop for computing sum of moments of UD load for Rb%
for i=1:nv
        Rb=Rb+uLoad(i)*uSpan(i)*(uLoc(i)-aLoc+uSpan(i)/2);
        sum=sum+uLoad(i)*uSpan(i);
end
for i=1:nm
    Rb=Rb+mLoad(i);
end
Rb=Rb/(bLoc-aLoc);
Ra=sum-Rb;
x=0;
V=zeros(1,(L/0.01)+1);
M=zeros(1,(L/0.01)+1);
%X=zeros(1,(L/0.01)+1);
X=[];
for i=1:(L/0.01)+1
    X=[X,x];
    x=x+0.01;
end
%Common region of all loads loop%
for j=1:(L/0.01)+1
        if(X(j)>aLoc)
            m=Ra*(X(j)-aLoc);
            v=Ra;
            M(j)=M(j)+m;
            V(j)=V(j)+v;
        end
        if(X(j)>bLoc)
            m=Rb*(X(j)-bLoc);
            v=Rb;
            M(j)=M(j)+m;
            V(j)=V(j)+v;
        end
end
%Point Load loop%
for i=1:np
    for j=1:(L/0.01)+1 
        if(X(j)>pLoc(i))
            m= -pLoad(i)*(X(j)-pLoc(i));
            v= -pLoad(i);
            M(j)=M(j)+m;
            V(j)=V(j)+v;
        end
    end
end
%UD load loop%
for i=1:nv
    for j=1:(L/0.01)+1
         if(X(j)>=uLoc(i) && X(j)<=uLoc(i)+uSpan(i))
            m=-uLoad(i)*(X(j)-uLoc(i))*(X(j)-uLoc(i))/2;
            v=-uLoad(i)*(X(j)-uLoc(i));
            M(j)=M(j)+m;
            V(j)=V(j)+v;
         end
        if(X(j)>uLoc(i)+uSpan(i))
            m=-uLoad(i)*uSpan(i)*(X(j)-uLoc(i)-uSpan(i)/2);
            v=-uLoad(i)*uSpan(i);
            M(j)=M(j)+m;
            V(j)=V(j)+v;
        end
    end
end
%External Moment loop%
for i=1:nm
    for j=1:(L/0.01)+1 
        if(X(j)>mLoc(i))
            m= mLoad(i);
            M(j)=M(j)+m;
        end
    end
end
y=zeros(length(M),1);
subplot (2,1,1),plot(X,M);
title('Moment Diagram (Nm vs m)');
hold on;
plot(X,y,'r')
hold on;
subplot (2,1,2),plot(X,V);
title("Shear Force Diagram (N vs m)");
hold on;
plot(X,y,'r')
hold on;
% plot(allAxes(6),[a a],[b b]);
%clear
%clc
end





if (t==1) %Cantilever%

    
L=input("Enter the length of beam (in meters)");
L=round(L,4,'significant');
np=input("Enter the number of point loads");
nv=input("Enter the number of UDL");
nm=input("Enter the number of External Moments");
pLoad=[];  %point load matrix%
pLoc=[];   %point load location matrix&
%z is a dummy variable%
for i=1:np
    z=input("Enter Point load (in Newton) "+i);
    pLoad=[pLoad,z];
    z=input("Enter location of Point load (from left end) "+i);
    z=round(z,4,'significant');
    pLoc=[pLoc,z];
end
uLoad=[]; %UD load matrix%
uLoc=[];  %UD load location matrix%
uSpan=[]; %UD load span matrix%
for i=1:nv
    z=input("Enter UD load (in Newton/meters) "+i);
    uLoad=[uLoad,z];
    z=input("Enter location of UD load (from left end) "+i);
    z=round(z,4,'significant');
    uLoc=[uLoc,z];
    z=input("Enter the span of UD load"+i);
    z=round(z,4,'significant');
    uSpan=[uSpan,z];
end
mLoad=[];
mLoc=[];
for i=1:nm
    z=input("Enter the External Moment (in Newton meters)");
    mLoad=[mLoad,z];
    z=input("Enter the location of Moment (from left end)");
    mLoc=[mLoc,z];
end
%Loop for computing sum of moments of point load for Rb%
Rb=0;
Mb=0;
sum=0;
for i=1:np
    Mb=Mb+pLoc(i)*pLoad(i);
    sum=sum+pLoad(i);
end
%Loop for computing sum of moments of UD load for Rb%
for i=1:nv
        Mb=Mb+uLoad(i)*uSpan(i)*(uLoc(i)+uSpan(i)/2);
        sum=sum+uLoad(i)*uSpan(i);
end
%Moment contribution%
for i=1:nm
    Mb=Mb+mLoad(i);
end
Rb=sum;
x=0;
V=zeros(1,(L/0.01)+1);
M=zeros(1,(L/0.01)+1);
%X=zeros(1,(L/0.01)+1);
X=[];
for i=1:(L/0.01)+1
    X=[X,x];
    x=x+0.01;
end
%Common region of all loads loop%
for j=1:(L/0.01)+1
            m=Rb*X(j)-Mb;
            v=Rb;
            M(j)=M(j)+m;
            V(j)=V(j)+v;
end
%Point Load loop%
for i=1:np
    for j=1:(L/0.01)+1 
        if(X(j)>pLoc(i))
            m= -pLoad(i)*(X(j)-pLoc(i));
            v= -pLoad(i);
            M(j)=M(j)+m;
            V(j)=V(j)+v;
        end
    end
end
%UD load loop%
for i=1:nv
    for j=1:(L/0.01)+1
         if(X(j)>=uLoc(i) && X(j)<=uLoc(i)+uSpan(i))
            m=-uLoad(i)*(X(j)-uLoc(i))*(X(j)-uLoc(i))/2;
            v=-uLoad(i)*(X(j)-uLoc(i));
            M(j)=M(j)+m;
            V(j)=V(j)+v;
         end
        if(X(j)>uLoc(i)+uSpan(i))
            m=-uLoad(i)*uSpan(i)*(X(j)-uLoc(i)-uSpan(i)/2);
            v=-uLoad(i)*uSpan(i);
            M(j)=M(j)+m;
            V(j)=V(j)+v;
        end
    end
end
%External Moment loop%
for i=1:nm
    for j=1:(L/0.01)+1 
        if(X(j)>mLoc(i))
            m= mLoad(i);
            M(j)=M(j)+m;
        end
    end
end

y=zeros(length(M),1);
subplot (2,1,1),plot(X,M);
title('Moment Diagram (Nm vs m) ');
hold on;
plot(X,y,'r')
hold on;
subplot (2,1,2),plot(X,V);
title("Shear Force Diagram (N vs m) ");
hold on;
plot(X,y,'r')
hold on;


%clear
%clc

end