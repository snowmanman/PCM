function [ inliers ] = Ransac( alldata,p )
%  RANSAC is an iterative mathematical algorithm that is capable of fitting a set of 2D or 3D spatial data containing outliers (or noise) into a speci?c geometric model such as a line, plane or sphere. 
%����Ransac �����ƽ��
%   dataΪ���ƽ������ݵ㼯��
%   alldata is all points for calculation
%   p Ϊ�ڵ��������ݼ��еĸ���
%   p is Probability for inliers points
%   sigma ,distanceΪ������ֵ������Ϊ��㣬С��Ϊ�ڵ㣬������̭�㡣
iter1 =log(0.01)/log(1-(p^3));
   iter =  floor(iter1); %ȡ����
   iter = 1000;
   data=alldata';
    number = size(data,2); % �ܵ���
 %bestParameter1=0; bestParameter2=0; bestParameter3=0; % ���ƥ��Ĳ���
 
 pretotal=-1;     %�������ģ�͵����ݵĸ���
 
   idx = randperm(number,3); 
     sample = data(:,idx); 

     %%%���ֱ�߷��� z=ax+by+c
     plane = zeros(1,3);
     x = sample(:, 1);
     y = sample(:, 2);
     z = sample(:, 3);

     a = ((z(1)-z(2))*(y(1)-y(3)) - (z(1)-z(3))*(y(1)-y(2)))/((x(1)-x(2))*(y(1)-y(3)) - (x(1)-x(3))*(y(1)-y(2)));
     b = ((z(1) - z(3)) - a * (x(1) - x(3)))/(y(1)-y(3));
     c = z(1) - a * x(1) - b * y(1);
     plane = [a b -1 c];
      mask1=abs(plane*[data; ones(1,size(data,2))]);    %��ÿ�����ݵ����ƽ��ľ���
     stad=std(mask1);
     sigma=stad*2;
for i=1:iter
 %%% ���ѡ��������
     idx = randperm(number,3); 
     sample = data(:,idx); 

     %%%���ֱ�߷��� z=ax+by+c
     plane = zeros(1,3);
     x = sample(:, 1);
     y = sample(:, 2);
     z = sample(:, 3);

     a = ((z(1)-z(2))*(y(1)-y(3)) - (z(1)-z(3))*(y(1)-y(2)))/((x(1)-x(2))*(y(1)-y(3)) - (x(1)-x(3))*(y(1)-y(2)));
     b = ((z(1) - z(3)) - a * (x(1) - x(3)))/(y(1)-y(3));
     c = z(1) - a * x(1) - b * y(1);
     plane = [a b -1 c];

     mask=abs(plane*[data; ones(1,size(data,2))]);    %��ÿ�����ݵ����ƽ��ľ���
     total=sum(mask<sigma);              %�������ݾ���ƽ��С��һ����ֵ�����ݵĸ���

     if total>pretotal            %�ҵ��������ƽ�������������ƽ��
         pretotal=total;
         bestplane=plane;          %�ҵ���õ����ƽ��
    end  
 end
 %��ʾ���������ϵ�����
mask=abs(bestplane*[data; ones(1,size(data,2))])<sigma;    
hold on;
k = 1;
inliers=[0 0 0];
for i=1:length(mask)
    if mask(i)
        inliers(k,1) = data(1,i);
        inliers(k,2) = data(2,i);
        inliers(k,3) = data(3,i);
        k = k+1;
    end
end


end

