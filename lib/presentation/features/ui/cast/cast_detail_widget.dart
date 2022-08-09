import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprintf/sprintf.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../data/constants.dart';
import '../../../../domain/models/cast_detail.dart';
import '../../../utils/logger/logger.dart';
import '../../../utils/model_converter.dart';
import '../../../widgets/common_widgets.dart';
import '../base/base_stateful_widget.dart';
import '../detail/movie/movie_detail_widget.dart';
import '../movie_by/movie_by_cast/movie_by_cast_widget.dart';
import 'cast_detail_bloc.dart';
import 'cast_detail_states.dart';

class CastDetailWidget extends BaseStatefulWidget {
  final int castId;

  const CastDetailWidget(this.castId, {Key? key}) : super(key: key);

  @override
  _CastDetailWidgetState createState() => _CastDetailWidgetState();
}

class _CastDetailWidgetState extends State<CastDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CastDetailBloc(
        RepositoryProvider.of(context),
        RepositoryProvider.of(context),
        widget.castId,
      ),
      child: Builder(builder: (context) {
        return Scaffold(
          body: SafeArea(
            child: BlocBuilder<CastDetailBloc, CastDetailState>(
                builder: (context, state) {
              if (state is CastDetailLoaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      color: Colors.yellow,
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _buildProfileImage(state.castDetail),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _buildCastName(state.castDetail),
                                _buildBirthday(state.castDetail),
                                _buildGender(state.castDetail),
                                _buildLocation(state.castDetail),
                                _buildImdb(state.castDetail),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    _buildMovieBanner(state.castDetail),
                    Expanded(
                      child: BlocBuilder<CastDetailBloc, CastDetailState>(
                          builder: (context, state) {
                        if (state is MovieByCastLoaded) {
                          return buildMovieList(
                            state.movies.toMedia(),
                            context,
                            itemClickListener: (item) => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetailWidget(
                                  movieId: item.id!,
                                  movieTitle: item.title!,
                                ),
                              ),
                            ),
                          );
                        }
                        return Container();
                      }),
                    ),
                  ],
                );
              }
              return Container();
            }),
          ),
        );
      }),
    );
  }

  Container _buildMovieBanner(CastDetail castDetail) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.blue,
      child: Row(
        children: [
          const Text(
            'Movies:',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
            ),
          ),
          Expanded(child: Container()),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: MaterialButton(
              child: const Text(
                'See Full',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MovieByCastWidget(
                          castDetail.id!, "${castDetail.name}'s movies"))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImage(CastDetail castDetail) {
    return Image.network(
      castDetail.profilePath!,
      width: 150,
    );
  }

  Widget _buildImdb(CastDetail castDetail) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      margin: const EdgeInsets.only(top: 20),
      child: InkWell(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/ic_imdb.png',
              width: 40,
              height: 40,
            ),
            const SizedBox(width: 5),
            const Text('IMDB Info',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                )),
          ],
        ),
        onTap: () => _openCastImdbPage(castDetail),
      ),
    );
  }

  Widget _buildLocation(CastDetail castDetail) {
    return _buildTextInfo(
      'Location: ' + castDetail.placeOfBirth!,
    );
  }

  Widget _buildGender(CastDetail castDetail) {
    String gender;
    if (castDetail.gender == 2) {
      gender = 'Male';
    } else if (castDetail.gender == 1) {
      gender = 'Female';
    } else {
      gender = 'Other';
    }
    return _buildTextInfo('Gender: ' + gender);
  }

  Widget _buildBirthday(CastDetail castDetail) {
    return _buildTextInfo('Birthday: ' + castDetail.birthday!);
  }

  Widget _buildCastName(CastDetail castDetail) {
    return Text(castDetail.name!,
        style: const TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w600,
        ));
  }

  Widget _buildTextInfo(String text) {
    return Container(
      child: Text(text),
      margin: const EdgeInsets.only(top: 5),
    );
  }

  _openCastImdbPage(CastDetail castDetail) async {
    if (Platform.isAndroid) {
      final url = sprintf(urlImdbCast, [castDetail.imdbId]);
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        Logger.w('Fail launch url $url');
      }
    }
  }
}
