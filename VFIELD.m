function [u,w] = VFIELD(x,z,Uinf,vortices_g,vortices_x,vortices_z,wake_g,wake_x,wake_z,limit_vortices_wake)
%VFIELD Calculates the local velocity at x, z in a potential flow field
%with free-stream velocity Uinf, and affected by thin bodies and wakes,
%represented by vortices_g/x/z and wake_g/x/z.
% VFIELD uses VOR2D to assemble a loop that considers all vortices on the
% game (plates + wakes) and returns the velocity that the is to be found
% at a point x, z. In order to achieve this the freestream velocity has
% to be known.

%Extracting parameters
%n_plates=size(vortices_g,1);
n_plates=1;
plate=1;
u=0;
w=0;

for plate=1:n_plates
    % plates influence
    [uu,ww]=VOR2D(vortices_g(plate,:),x,z,vortices_x(plate,:),vortices_z(plate,:));
    u=u+uu;
    w=w+ww;
    % wakes influence
    [uu,ww]=VOR2D(wake_g(plate,1:limit_vortices_wake),x,z,wake_x(plate,1:limit_vortices_wake),wake_z(plate,1:limit_vortices_wake));
    u=u+uu;
    w=w+ww;
end
%u=u+Uinf;
end
