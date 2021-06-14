% Density-based spatial clustering of applications with noise (DBSCAN)
% Use dbscan to perform clustering on an input data matrix or on pairwise distances between observations. 
% DBSCAN is now can be applied by using dbscan function in matlab
idx = dbscan(X,epsilon,minpts) 
% partitions observations in the n-by-p data matrix X into clusters using the DBSCAN algorithm (see Algorithms). dbscan clusters the observations (or points) based on a threshold for a neighborhood search radius epsilon and a minimum number of neighbors minpts required to identify a core point. The function returns an n-by-1 vector (idx) containing cluster indices of each observation.
idx = dbscan(X,epsilon,minpts,Name,Value) 
% specifies additional options using one or more name-value pair arguments. For example, you can specify 'Distance','minkowski','P',3 to use the Minkowski distance metric with an exponent of three in the DBSCAN algorithm.
idx = dbscan(D,epsilon,minpts,'Distance','precomputed') 
% returns a vector of cluster indices for the precomputed pairwise distances D between observations. D can be the output of pdist or pdist2, or a more general dissimilarity vector or matrix conforming to the output format of pdist or pdist2, respectively.
[idx,corepts] = dbscan(___) 
% also returns a logical vector corepts that contains the core points identified by dbscan, using any of the input argument combinations in the previous syntaxes.
