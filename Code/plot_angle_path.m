function plot_angle_path (x,y,angle,queue_length,points_jump,linewidt)
%Antoine's function to plot the location and orientation tail.
 
if nargin<6;
    linewidt=1;
end

%point_jump: take one value every point jump; if point_jump=1 means takes
%all the point

[x_angle y_angle] = pol2cart (angle,queue_length);
x_dir = x + x_angle;
y_dir = y + y_angle;

point_number = length (x);

k=1;
for i = 1:points_jump:point_number;
    X(k)=x(i);
  X_dir(k)=x_dir(i);
    Y(k)=y(i);
    Y_dir(k)=y_dir(i);
    k=k+1;
end

    
both_X = [X;X_dir];
both_Y = [Y;Y_dir];


plot (both_X, both_Y,'r','linewidth',linewidt);hold on;
scatter (X,Y,'k','.'); hold on
    


