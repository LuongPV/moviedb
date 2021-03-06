const API_KEY_THE_MOVIE_DB = '72ca6ce7e0d22478aca5df10518f5888';
const API_KEY_YOUTUBE = 'AIzaSyD9TELvgF17-dznalY8FekFFce_tkrwncU';
const URL_MOVIE_SEARCH = 'https://api.themoviedb.org/3/search/movie?query=%s&api_key=$API_KEY_THE_MOVIE_DB&language=%s';
const URL_MOVIE_DETAIL = 'https://api.themoviedb.org/3/movie/%d?api_key=$API_KEY_THE_MOVIE_DB&language=%s';
const URL_MOVIE_DETAIL_CAST = 'https://api.themoviedb.org/3/movie/%d/credits?api_key=$API_KEY_THE_MOVIE_DB&language=%s';
const URL_TV_SHOW_DETAIL = 'https://api.themoviedb.org/3/tv/%d?api_key=$API_KEY_THE_MOVIE_DB&language=%s';
const URL_TV_SHOW_DETAIL_CAST = 'https://api.themoviedb.org/3/tv/%d/credits?api_key=$API_KEY_THE_MOVIE_DB&language=%s';
const URL_MOVIE_BY_GENRE = 'https://api.themoviedb.org/3/discover/movie?with_genres=%s&api_key=$API_KEY_THE_MOVIE_DB&language=%s';
const URL_MOVIE_BY_CAST = 'https://api.themoviedb.org/3/person/%d/movie_credits?api_key=$API_KEY_THE_MOVIE_DB&language=%s';
const URL_VIDEO_BY_MOVIE = 'https://api.themoviedb.org/3/movie/%d/videos?api_key=$API_KEY_THE_MOVIE_DB&language=%s';
const URL_YOUTUBE_VIDEO_INFO = 'https://www.googleapis.com/youtube/v3/videos?key=$API_KEY_YOUTUBE&part=snippet&id=%s';
const URL_YOUTUBE_VIEW_VIDEO = 'https://www.youtube.com/watch?v=%s';
const URL_CAST_DETAIL = 'https://api.themoviedb.org/3/person/%d?api_key=$API_KEY_THE_MOVIE_DB&language=%s';
const URL_MOVIE_IMAGE = 'http://image.tmdb.org/t/p/w500%s';
const URL_YOUTUBE_SEARCH = 'https://www.youtube.com/results?search_query=%s';
const URL_IMDB_CAST = 'https://www.imdb.com/name/%s';
const URL_TRENDING = 'https://api.themoviedb.org/3/trending/%s/day?api_key=$API_KEY_THE_MOVIE_DB&language=%s';
const DELAY_CONFIRM_EXIT_SEC = 2;
const API_KEY_LOCATION_SERVICE = 'AIzaSyBmVjdTVugqq4O2r2RL-rBvI5B7E-VlelU';
const URL_GOOGLE_NEARBY_PLACE = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%f,%f&radius=5000&type=%s&key=$API_KEY_LOCATION_SERVICE';
const URL_GOOGLE_DIRECTION = 'https://maps.googleapis.com/maps/api/directions/json?origin=%f,%f&destination=%f,%f&key=$API_KEY_LOCATION_SERVICE';
const PLACE_TYPE_MOVIE_THEATER = 'movie_theater';
