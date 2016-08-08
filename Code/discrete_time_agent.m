function [x,y,th] =Agent(map, time,gain, display,start_pos)

%%To run it
% gain=-200; % transform transiant into angle
% load ('Odourgradient_side');
% display=1;
% time=100;
% [x,y,th] =Agent(map, time,gain, display)

%%
%(x,y) are the head coordinate
%th is the current direction of travel; so th+pi is towards the anterior
%half of the body (we don't need to model here the posterior half, which is
%assume to tray behind).

% Spontaneous condition
r=10; %this is how much it goes forward (10=1mm)
spont_angle=15/180*pi; %base swing angle in radian
max_angle = 180/180*pi;
min_angle = 0/180*pi;

%starting condition
if nargin<5;
x=rand*644 +1; %just to avoid it start on the actual edge
y=1012/2; %Start in the middle between both odours
else
x=start_pos(1);
y=start_pos(2);
end

% y=rand*1012 +1;
th=rand*2*pi;
percept=[0 0]; 
ocill='l'; %alternate between left ('l') and right ('r') state.

%%
for i=1:time;%i refer to time before movement. In reality, roughly 1/s. 
    
 
    %----------smell at time -i------------.
    
    percept(1)=percept(2);%previous head position
    percept(2)= map(round(y(i)),round(x(i))) ;%new head position
    
    OSN_transiant=percept(2)-percept(1);


      angle_modul = OSN_transiant*gain; %this is the signal strengh transmitted to motor control
      
      
    turn_angle = spont_angle + angle_modul;
        if turn_angle>max_angle; turn_angle=max_angle;end
        if turn_angle<min_angle; turn_angle=min_angle;end
        if ocill=='r'; turn_angle=-turn_angle; end

    %--------move to time i+1------------   
    
    th(i+1)= th(i)+turn_angle;%set the new heading
        
    [X, Y]=pol2cart(th(i+1),r); %move along this direction
    x(i+1)= x(i)+X;
    y(i+1)= y(i)+Y;
    
    %in case it hit the boundary; bounce randomnly
    if x(i+1)<1;x(i+1)=1; th(i+1)=rand*2*pi;end
    if x(i+1)>size(map,2);x(i+1)=size(map,2);th(i+1)=rand*2*pi;end
    if y(i+1)<1;y(i+1)=1;th(i+1)=rand*2*pi;end
    if y(i+1)>size(map,1);y(i+1)=size(map,1);th(i+1)=rand*2*pi;end
        
    
     if ocill=='l'; ocill='r';else ocill='l';end

end
%%
if display==1;
%  figure();
 contour(map,'b'); hold on;
 plot(x,y,'k'); hold on;
 plot_angle_path (x,y,th-pi,5,1,2);
 axis equal; %axis('tight');
 axis([0 size(map,2) 0 size(map,1)]);
end
