if exist('CurrentSizeTrail','var') %CurrentSizeTrail generated from the CheckMovieInfo script.
    if ~isempty(handles.IO.Session)
    if i==1 && CurrentSizeTrail(i)>0
    Trigger(handles.IO.Session,2,1);
    Trigger2 = 1;
    elseif sum(CurrentSizeTrail(:,i))>0 && sum(CurrentSizeTrail(:,i-1))==0
        Trigger(handles.IO.Session,2,1);
        Trigger2 = 1;
    elseif sum(CurrentSizeTrail(:,i))==0 && sum(CurrentSizeTrail(:,i-1)) > 0
        Trigger(handles.IO.Session,2,0);
        Trigger2 = 0;
    end
    end
end