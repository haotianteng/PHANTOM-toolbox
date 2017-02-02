if isfield(handles.movieStore,'MovieInfo')
    if isfield(handles.movieStore.MovieInfo{MovieIndex},'PlainMovieInfo')
        if isfield(handles.movieStore.MovieInfo{MovieIndex}.PlainMovieInfo,'FreshRate')
            handles.frames = handles.movieStore.MovieInfo{MovieIndex}.PlainMovieInfo(1).FreshRate;
            set(handles.FreshRate,'String',['Screen monitor fresh rate is ',num2str(handles.freshRate),'.',' Movie fresh rate is ',num2str(handles.frames),'.']);
        end
        if isfield(handles.movieStore.MovieInfo{MovieIndex}.PlainMovieInfo,'SpotInfo')
            if ~isempty(handles.movieStore.MovieInfo{MovieIndex}.PlainMovieInfo(1).SpotInfo)
                CurrentSizeTrail = zeros(length(handles.movieStore.MovieInfo{MovieIndex}.PlainMovieInfo),length(handles.movieStore.MovieInfo{MovieIndex}.PlainMovieInfo(1).SpotInfo.SizeTrail));
                for SpotIndex = 1:length(handles.movieStore.MovieInfo{MovieIndex}.PlainMovieInfo)
                    CurrentSizeTrail(SpotIndex,:) = handles.movieStore.MovieInfo{MovieIndex}.PlainMovieInfo(SpotIndex).SpotInfo.SizeTrail;
                end
            end
        elseif isfield(handles.movieStore.MovieInfo{MovieIndex}.PlainMovieInfo,'BarInfo')
            if ~isempty(handles.movieStore.MovieInfo{MovieIndex}.PlainMovieInfo(1).BarInfo)
                CurrentSizeTrail = ones(1,handles.movieStore.MovieInfo{MovieIndex}.PlainMovieInfo(1).BarInfo.OnTime*handles.movieStore.MovieInfo{MovieIndex}.PlainMovieInfo(1).FreshRate);
            end
        end
    end
end