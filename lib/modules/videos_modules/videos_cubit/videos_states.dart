abstract class VideosStates {}

class VideosInitialState extends VideosStates {}

class GetVideosLoadingState extends VideosStates {}

class GetVideosSuccessState extends VideosStates {}

class GetVideosErrorState extends VideosStates {}

class LoadControllerStartState extends VideosStates {}

class LoadControllerEndState extends VideosStates {}

class NewState extends VideosStates {}
