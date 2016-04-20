backGroundTextureIndex=Screen('MakeTexture', handles.win1, handles.backGroundIm);
Screen('DrawTexture', handles.win1, backGroundTextureIndex);
if ~isempty(handles.patternIm)
patternTextureIndex=Screen('MakeTexture', handles.win1, handles.patternIm);
Screen('DrawTexture', handles.win1, patternTextureIndex);
end
TimeStamp=Screen('Flip', handles.win1);