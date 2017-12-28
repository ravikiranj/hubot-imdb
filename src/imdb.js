// Description:
//   Returns IMDB search result for the search query
//
// Dependencies:
//   None
//
// Configuration:
//   HUBOT_OMDB_API_KEY
//
// Commands:
//   hubot (imdb|movie) <movie>
//
// Author:
//   orderedlist, ravikiranj

if (process.env.HUBOT_OMDB_API_KEY === undefined) {
  throw new Error("HUBOT_OMDB_API_KEY is not defined, exiting!");
}

module.exports = robot =>
    robot.respond(/(imdb|movie)( me)? (.*)/i, function(msg) {
        const query = msg.match[3];
        return msg.http("https://www.omdbapi.com")
            .query({
                apikey: process.env.HUBOT_OMDB_API_KEY,
                s: query
            })
            .get()(function(err, res, body) {
                const movieResults = JSON.parse(body);
                try {
                    if (movieResults != null && movieResults.Search != null && movieResults.Search.length > 0) {
                        const movie = movieResults.Search[0];
                        const imdbUrl = `www.imdb.com/title/${movie.imdbID}`;
                        msg.send(`${movie.Title} (${movie.Year}) - ${imdbUrl}`);
                        if (movie.Poster != null) {
                            msg.send(`${movie.Poster}`);
                        }
                    } else {
                        msg.send("That's not a movie, yo.");
                    }
                } catch (error) {
                    robot.logger.error("IMDB error stacktrace =", error.stack);
                    msg.send("There was an error fetching movie info.");
                }
        });
    })
;
