function y=fuzzy_Kmeans(X,k,m,U,e) 
k=2;  %自定义 k 个类中心数
X=[0 0;0 1;3 1;3 2];% 样本
U=[0.9 0.8 0.7 0.1;0.1 0.2 0.3 0.9];  %隶属度初始值
%  load  fisheriris;X=meas;[M,N]=size(X);U=1/k*ones(k,M);U(1,1)=U(1,1)-0.1;U(k,1)=U(k,1)+0.1;%Iris 测试数据集 ,目的是让 U 的值不全为 1/k 

%%%%%%%%%%%% 初始化
m=2;  %控制模糊程度的参数
e=0.0001;  %达到收敛时最小误差
UL=membership(U,X,m); % 求隶属度
err=abs(UL-U);  %误差
while(max(err(1,:))>e)  %收敛条件没达到要求，则继续迭代
temp=UL;  %保存先前的隶属度
UL=membership(UL,X,m);  %更新隶属度
err=abs(UL-temp);  %更新误差
end 
UL  %输出最终的隶属度矩阵

%%%%%%%%%%%%% 通过最终所获得的隶属度矩阵，判断样本所属类别
class=cell(k,1); % 初始化类样本 class 
for i=1:size(X,1); 
[MAX,index]=max(UL(:,i)); 
class{index}=cat(1,class{index},i); 
end 
celldisp(class);% 显示 Kmeans 聚类结果

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 子函数部分
function y=membership(U0,X,m)
%U0 初始隶属度矩阵， X 为需聚类样本， m 为控制聚类结果的模糊程度， y 为返回的新的隶属度
classNum=size(U0,1); % 求出类别数
for i=1:classNum 
U0(i,:)=U0(i,:).^m; % 隶属度各值平方
end 
Z=zeros(classNum,size(X,2));% 聚类中心初始化
for i=1:classNum 
for j=1:size(X,1) 
Z(i,:)=Z(i,:)+U0(i,j)*X(j,:); 
end 
Z(i,:)=Z(i,:)/sum(U0(i,:)); % 计算聚类中心
end 
for i=1:size(X,1) 
for j=1:size(Z,1) 
d(i,j)=dist(X(i,:),Z(j,:)')^(2/(m-1));% 求距离
end 
end 
[m,n]=size(d); 
u=zeros(m,n);% 新的隶属度初始化
for i=1:m 
for j=1:n 
for k=1:n 
u(i,j)=u(i,j)+d(i,j)/d(i,k); 
end 
u(i,j)=1/u(i,j);  %由隶属度更新公式
end 
end 
y=u'; 