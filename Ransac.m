function [ inliers ] = Ransac( alldata,p )
%  RANSAC is an iterative mathematical algorithm that is capable of fitting a set of 2D or 3D spatial data containing outliers (or noise) into a speci?c geometric model such as a line, plane or sphere. 
%进行Ransac 的拟合平面
%   data为拟合平面的数据点集，
%   alldata is all points for calculation
%   p 为内点所在数据集中的概率
%   p is Probability for inliers points
%   sigma ,distance为距离阈值，大于为外点，小于为内点，用于淘汰点。
iter1 =log(0.01)/log(1-(p^3));
   iter =  floor(iter1); %取整数
   iter = 1000;
   data=alldata';
    number = size(data,2); % 总点数
 %bestParameter1=0; bestParameter2=0; bestParameter3=0; % 最佳匹配的参数
 
 pretotal=-1;     %符合拟合模型的数据的个数
 
   idx = randperm(number,3); 
     sample = data(:,idx); 

     %%%拟合直线方程 z=ax+by+c
     plane = zeros(1,3);
     x = sample(:, 1);
     y = sample(:, 2);
     z = sample(:, 3);

     a = ((z(1)-z(2))*(y(1)-y(3)) - (z(1)-z(3))*(y(1)-y(2)))/((x(1)-x(2))*(y(1)-y(3)) - (x(1)-x(3))*(y(1)-y(2)));
     b = ((z(1) - z(3)) - a * (x(1) - x(3)))/(y(1)-y(3));
     c = z(1) - a * x(1) - b * y(1);
     plane = [a b -1 c];
      mask1=abs(plane*[data; ones(1,size(data,2))]);    %求每个数据到拟合平面的距离
     stad=std(mask1);
     sigma=stad*2;
for i=1:iter
 %%% 随机选择三个点
     idx = randperm(number,3); 
     sample = data(:,idx); 

     %%%拟合直线方程 z=ax+by+c
     plane = zeros(1,3);
     x = sample(:, 1);
     y = sample(:, 2);
     z = sample(:, 3);

     a = ((z(1)-z(2))*(y(1)-y(3)) - (z(1)-z(3))*(y(1)-y(2)))/((x(1)-x(2))*(y(1)-y(3)) - (x(1)-x(3))*(y(1)-y(2)));
     b = ((z(1) - z(3)) - a * (x(1) - x(3)))/(y(1)-y(3));
     c = z(1) - a * x(1) - b * y(1);
     plane = [a b -1 c];

     mask=abs(plane*[data; ones(1,size(data,2))]);    %求每个数据到拟合平面的距离
     total=sum(mask<sigma);              %计算数据距离平面小于一定阈值的数据的个数

     if total>pretotal            %找到符合拟合平面数据最多的拟合平面
         pretotal=total;
         bestplane=plane;          %找到最好的拟合平面
    end  
 end
 %显示符合最佳拟合的数据
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

