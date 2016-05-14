function TransferProcess
<<<<<<< HEAD
filename = 'Convection2D_2_40.nc';

time = ncread(filename, 'time');
% timestep = numel(time)
x = ncread(filename, 'x');
y = ncread(filename, 'y');



p_h = point3D(filename, x, y, time);
end% func

function p_h = point3D(filename, x, y, time)
ind = 1:1:numel(x);
itime = 1;
var = ncread(filename, 'h', [1, itime],[inf, 1]);
p_h = plot3(x(ind), y(ind), var(ind), '.');
zlim([-0.5, 1.2]);
view(-22.7, 57.2);

camera_on = 1;
if camera_on
    writerObj = VideoWriter('Triangle2_40.avi');
    writerObj.FrameRate = 60;
    open(writerObj);
end

for itime = 1:1:numel(time)
    var = ncread(filename, 'h', [1, itime],[inf, 1]);
    
    set(p_h, 'ZData', var(ind));
    drawnow;
    
    if camera_on
        frame = getframe(gcf);
        writeVideo(writerObj,frame);
    end
    fprintf('Processing: %f ...\n', itime/numel(time))
end% for

if camera_on
    close(writerObj);
end
=======
filename = 'Convection2D_2_20.nc';

time = ncread(filename, 'time');
% timestep = numel(time)
x = ncread(filename, 'x'); nx = numel(x);
y = ncread(filename, 'y');

itime = 1;
var = ncread(filename, 'h', [1, itime],[inf, 1]);

p_h = point3D(filename, x, y, var, time);

end% func

function p_h = point3D(filename, x, y, var, time)
ind = 1:6:numel(x);

% subplot(2, 1, 1);
p_h = plot3(x(ind), y(ind), var(ind), '.');
zlim([-0.5, 1.2])

% subplot(2, 1, 2);
% dis = ncread(filename, 'temp', [1, 1], [inf, 1]);
% 
% % contour plot
% np = 100;
% r = linspace(-1, 1, np);
% [X, Y] = meshgrid(r, r);
% Z = griddata(x(ind), y(ind), dis, X, Y, 'linear');
% v = [0:0.2:1.2];
% [~, c_h] = contourf(X, Y, Z, v);
% colorbar

% gather information
% sumCell = zeros(numel(time), 1);

for itime = 1:numel(time)
    var = ncread(filename, 'h', [1, itime],[inf, 1]);
    dis = ncread(filename, 'temp', [1, itime], [inf, 1]);
    
    set(p_h, 'ZData', var(ind));
%     set(p2_h, 'ZData', dis);
    
%     Z = griddata(x(ind), y(ind), dis, X, Y, 'linear');
%     set(c_h, 'ZData', Z);
    drawnow;
%     sumCell(itime) = sum(var(1:6));
    fprintf('Processing: %f ...\n', itime/numel(time))
    
%     if itime > 780
%         keyboard;
%     end
%     if sum(abs(var(1:6))) > 0.01
%         keyboard;
%     end
end% for

% plot(time, sumCell)
>>>>>>> master
end% func