function handle=crash(handle,n,r,i,j,min_time,deltat) 
       handle(1,:)=handle(1,:)+min_time*handle(3,:);
       handle(2,:)=handle(2,:)+min_time*handle(4,:);
       if j==n+1 && min_time<deltat
           handle(3,i)=-1*handle(3,i);
           handle(1,i)=r;
       end
       
       if j==n+2 && min_time<deltat
           handle(3,i)=-1*handle(3,i);
           handle(1,i)=1-r;
       end
       
       if j==n+3 && min_time<deltat
           handle(4,i)=-1*handle(4,i);
           handle(2,i)=r;
       end
       
       if j==n+4 && min_time<deltat
           handle(4,i)=-1*handle(4,i);
           handle(2,i)=1-r;
       end
       
       if j <= n && min_time < deltat
           swap = handle(3,i);
           handle(3,i) = handle(3,j);
           handle(3,j) = swap;
           swap = handle(4,i);
           handle(4,i) = handle(4,j);
           handle(4,j) = swap;
       end
       
       
       
       
       
       for i = 1:n
           if handle(1,i)<r
               handle(1,i)=r;
           end
           if handle(1,i)>1-r
               handle(1,i)=1-r;
           end    
           if handle(2,i)<r
               handle(2,i)=r;
           end
           if handle(2,i)>1-r
               handle(2,i)=1-r;
           end    
       end