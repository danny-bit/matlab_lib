function expfig (fname)

dpi = 300;

echo on

% cleanfigure: remove crazy stuff
cleanfigure();

% set font
eval(sprintf('export_fig %s -png -r%d -painters',fname,dpi))

echo off
end