function [dr, ds, dt] = derivative_orthogonal_func( obj, N, ind, r, s, t)
%GRADORTHOGONALFUN 标准三角形内正交函数导数值

% 坐标投影到矩阵
[a,b] = rstoab(r,s);

% 基函数序号转换为矩阵内函数编号（i，j）
[i, j] = trans_ind(N,ind);

% 计算对（r,s）坐标的导数
[dr, ds] = deri_simplex2DP(a,b,i,j);
dt = zeros(size(dr));
end

function [ dmodedr, dmodeds ] = deri_simplex2DP( a,b,id,jd )
% Return the derivatives of the modal basis (id,jd) on the 2D simplex at (a,b).
fa = Polylib.JacobiP(a, 0, 0, id);     
dfa = Polylib.GradJacobiP(a, 0, 0, id);
gb = Polylib.JacobiP(b, 2*id+1,0, jd); 
dgb = Polylib.GradJacobiP(b, 2*id+1,0, jd);
% r-derivative
% d/dr = da/dr d/da + db/dr d/db = (2/(1-s)) d/da = (2/(1-b)) d/da
dmodedr = dfa.*gb;
if(id>0)
    dmodedr = dmodedr.*((0.5*(1-b)).^(id-1));
end
% s-derivative
% d/ds = ((1+a)/2)/((1-b)/2) d/da + d/db
dmodeds = dfa.*(gb.*(0.5*(1+a)));
if(id>0)
    dmodeds = dmodeds.*((0.5*(1-b)).^(id-1));
end
tmp = dgb.*((0.5*(1-b)).^id);
if(id>0)
    tmp = tmp-0.5*id*gb.*((0.5*(1-b)).^(id-1));
end
dmodeds = dmodeds+fa.*tmp;
% Normalize
dmodedr = 2^(id+0.5)*dmodedr; dmodeds = 2^(id+0.5)*dmodeds;
end

