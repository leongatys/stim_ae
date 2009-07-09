function [e,retInt32,retStruct,returned] = netStartSession(e,params)

% initialize parent
[e,retInt32,retStruct,returned] = initSession(e,params);

idx = getParam(e,'imageNumber');
file = getParam(e,'imageFile');
file = load(file);
textures = file.textures(idx);

e.textureFile = textures;
e.textureNum = idx;

% Enable alpha blending with proper blend-function. We need it
% for drawing of our alpha-mask (gaussian aperture)
win = get(e,'win');
Screen('BlendFunction',win,GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
