%%
imaqhwinfo
%%
info = imaqhwinfo('winvideo')
%%
dev_info = imaqhwinfo('winvideo',1)

%%


%%
preview(vid)

%%

get(vid)

%%
get(getselectedsource(vid))

%%
vid = videoinput('winvideo',1,'YUY2_640x480')
vid.ReturnedColorSpace = 'grayscale';
vid.TriggerRepeat = 0;
vid.FramesPerTrigger = 600 % 600*3/30 = 60; || frames*3/frameRate = number of seconds recorded
vid.FrameGrabInterval = 3
vid.LoggingMode = 'disk';
logfile = VideoWriter('C:\Users\John\Documents\MATLAB\logfile.mp4', 'MPEG-4')
logfile.FrameRate = 10
logfile.Quality = 75


vid.DiskLogger = logfile;

vid



%%
% vid_src = getselectedsource(vid);


%%



%%
start(vid)
pause(100)
vid
% [~ , time] = getdata(vid);
datestr(vid.InitialTriggerTime)
% time(end) - time(1)
% size(dat)

%%

v = VideoReader('logfile.mp4');
v.Duration
v.NumFrames

%%

delete(vid);
clear vid