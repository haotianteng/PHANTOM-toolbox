if isfield(handles.movieStore,'MovieInfo')
    if isfield(handles.movieStore.MovieInfo{MovieIndex},'PlainMovieInfo')
        if isfield(handles.movieStore.MovieInfo{MovieIndex}.PlainMovieInfo,'FreshRate')
            handles.frames = handles.movieStore.MovieInfo{MovieIndex}.PlainMovieInfo.FreshRate;
            set(handles.FreshRate,'String',['FreshRate is ',num2str(handles.freshRate),' now',' Original Movie Fresh Rate is ',num2str(handles.frames),'.']);
        end
        if isfield(handles.movieStore.MovieInfo{MovieIndex}.PlainMovieInfo,'SpotInfo')
            if ~isempty(handles.movieStore.MovieInfo{MovieIndex}.PlainMovieInfo.SpotInfo)
            CurrentSizeTrail = handles.movieStore.MovieInfo{MovieIndex}.PlainMovieInfo.SpotInfo.SizeTrail;
            end
        end
    end
end