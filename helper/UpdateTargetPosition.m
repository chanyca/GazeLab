function param = UpdateTargetPosition(env, param)


param.target.dist_x_from_gaze_deg = randi([0,15]);
param.target.dist_x_from_gaze_pix = visualDegree2pix(param.target.dist_x_from_gaze_deg, env.screenXpixels, env.screenWidthCm, env.viewingDistanceCm);
param.target.dist_y_from_gaze_deg = randi([0,15]);
param.target.dist_y_from_gaze_pix = visualDegree2pix(param.target.dist_y_from_gaze_deg, env.screenXpixels, env.screenWidthCm, env.viewingDistanceCm);

return