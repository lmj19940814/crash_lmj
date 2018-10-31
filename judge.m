function crash_times=judge(handle,n,r,deltat)
       crash_times=ones(n,n+4);
          for i=1:n
              x_0_judge=-1*(handle(1,i)-r)/handle(3,i);
              y_0_judge=-1*(handle(2,i)-r)/handle(4,i);
              x_1_judge=(1-r-handle(1,i))/handle(3,i);
              y_1_judge=(1-r-handle(2,i))/handle(4,i);
            if x_0_judge<=0
                crash_times(i,n+1)=1 ;          %judge x=0
            elseif x_0_judge>3*deltat
                crash_times(i,n+1)=1;
            else   
                crash_times(i,n+1)=x_0_judge;
            end
            
            if y_0_judge<=0
                crash_times(i,n+3)=1  ;         %judge y=0
            elseif y_0_judge>3*deltat
                crash_times(i,n+3)=1;
            else   
                crash_times(i,n+3)=y_0_judge;
            end
              
            if x_1_judge<=0
                crash_times(i,n+2)=1  ;         %judge x=1
            elseif x_1_judge>3*deltat
                crash_times(i,n+2)=1;
            else   
                crash_times(i,n+2)=x_1_judge;
            end
             
            if y_1_judge<=0
                crash_times(i,n+4)=1  ;         %judge y=1
            elseif y_1_judge>3*deltat
                crash_times(i,n+4)=1;
            else   
                crash_times(i,n+4)=y_1_judge;
            end  
          end
         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
          
          for i=1:(n-1)
             for j=(i+1):n
               d=((handle(1,i)-handle(1,j))^2+(handle(2,i)-handle(2,j))^2)^0.5;
               relative_vx=handle(3,j)-handle(3,i);
               relative_vy=handle(4,j)-handle(4,i)  ;
               relative_x=handle(1,i)-handle(1,j);
               relative_y=handle(2,i)-handle(2,j);
               
               if (relative_vx>=0 && relative_vy>=0)||(relative_vx>=0 && relative_vy<=0)         %the angel of relative speed
                   theta1=atan(relative_vy/relative_vx);
               elseif (relative_vx<=0&&relative_vy<=0)
                   theta1=atan(relative_vy/relative_vx)-pi;
               elseif (relative_vx<=0&&relative_vy>=0)
                   theta1=pi-atan(relative_vy/relative_vx);
               end
               
               if (relative_x>=0&&relative_y>=0)||(relative_x>=0&&relative_y<=0)         %the angel of relative posistion
                   theta2=atan(relative_y/relative_x);
               elseif (relative_x<=0&&relative_y<=0)
                   theta2=atan(relative_y/relative_x)-pi;
               elseif (relative_x<=0&&relative_y>=0)
                   theta2=pi-atan(relative_y/relative_x);
               end
               
               
               if abs(theta1-theta2)>=pi/2
                   crash_times(i,j)=1;
                   %crash_time(j,i)=1
               elseif abs(theta1-theta2)==0
                    crash_times(i,j)=abs((d-2*r)/(relative_vx^2+relative_vy^2)^0.5);
                    %crash_time(j,i)=abs((d-2*r)/(relative_vx^2+relative_vy^2)^0.5)
               elseif abs(theta1-theta2)<pi/2 && abs(theta1-theta2)>0 && d*sin(abs(theta1-theta2))>2*r
                   
                      crash_times(i,j)=1;
                      %crash_time(j,i)=abs((d-2*r)/(relative_vx^2+relative_vy^2)^0.5) 
                elseif abs(theta1-theta2)<pi/2 && abs(theta1-theta2)>0 && d*sin(abs(theta1-theta2))<=2*r
                       alpha=pi-asin(0.5*d*sin(abs(theta1-theta2))/r);
                       s=d/sin(alpha)*sin(pi-alpha-abs(theta1-theta2));
                       crash_times(i,j)=s/(relative_vx^2+relative_vy^2)^0.5;
                       %crash_time(j,i)=s/(relative_vx^2+relative_vy^2)^0.5
                       if crash_times(i,j)>1
                           crash_times(i,j)=1;
                       end
                
               end
               
               
             end
          end
          