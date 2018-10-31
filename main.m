function main
initialization=load('initialization.txt');
n = initialization(1,1);                  
r = initialization(2,1);   
t = initialization(3,1); 
dt = initialization(4,1); 

  handle = [1/(n+1):1/(n+1):n/(n+1);1/(n+1):1/(n+1):n/(n+1);zeros(2,n)];             % the 1st and 2nd row of handle array are the position (x,y) of particiles ,initialize positions
  judge_initialization=judge_ruler(handle,n,r);
  
if judge_initialization==1
    disp('initialisation is successful')
else
    disp('initialisation is illegal ,please initialise again ')
   % n = input('please input the amount of particles n=');                  
   % r = input('please input the radius of the particles r=');   
   % t = input('please input the totle time t='); 
   % dt = input('please input the step time dt='); 
end


    handle(3:4,:)=normrnd(0,1,2,n);                  % the 3rd and 4th row of handle array are the speed (v_x,v_y) of particiles,,initialize speeds
    for time = 0:dt:t
       deltat = dt;
       while deltat > 0
          crash_times = judge(handle,n,r,deltat);
          [i,j,min_time] = order_time(crash_times,n);
          if min_time>deltat
              min_time=deltat;
          end
          handle = crash(handle,n,r,i,j,min_time,deltat) ;
          deltat = deltat-min_time;
       end 
    
       i = 1:n;
        clf;
        %scatter(handle(1,i),handle(2,i),'filled');
        %axis([0 1 0 1]);
        %axis equal;
        %pause(dt);
        for j=1:11;
          x(i,j)=handle(1,i)+r*cos(pi/5*j);
          y(i,j)=handle(2,i)+r*sin(pi/5*j);
        end
        
        
        hold on;
        for i=1:n
           %scatter(x(i,j),y(i,j),'filled');   
           plot(x(i,:),y(i,:),'b');
           %j=1:20
           %plot(x(i,j),y(i,j),'-')
           axis([0 1 0 1]);
           %axis equal;
           axis off
        end
         pause(dt);
    end
    
    
    
    
    
    
    