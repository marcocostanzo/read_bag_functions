function y = quintico_dot( t, qi,qf,qdi,qdf,qddi,qddf, ti, duration)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    tt=t-ti;
    
         %a5        a4          a3      a2      a1      a0
    A = [ 0         0           0       0       0       1;
          0         0           0       0       1       0;
          0         0           0       2       0       0;
          duration^5      duration^4        duration^3    duration^2    duration      1;
          5*duration^4    4*duration^3      3*duration^2  2*duration    1       0;
          4*5*duration^3  3*4*duration^2    3*2*duration  2       0       0;
          ];

   qi=qi(:)'; qdi=qdi(:)'; qddi=qddi(:)'; 
   qf=qf(:)'; qdf=qdf(:)'; qddf=qddf(:)'; 
   
   B=[ qi;qdi;qddi;qf;qdf;qddf];
   a=A\B; %A^-1*B
   
   for k=1:size(a,2)
        y(:,k)=polyval( polydiff(a(:,k)'), tt);
   end
end

