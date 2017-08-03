# Description:
#   Get the movie poster and synposis for a given query
#
# Dependencies:
#   None
#
# Configuration:
#
# Commands:
#   hubot (imdb|movie) <movie>
#
# Author:
#   orderedlist, ravikiranj

module.exports = (robot) ->
    robot.respond /(imdb|movie)( me)? (.*)/i, (msg) ->
        query = msg.match[3]
        msg.http("http://www.imdb.com/xml/find")
            .query({
                json: 1,
                nr: 1
                tt: on
                q: query,
            })
            .get() (err, res, body) ->
                movie = JSON.parse(body)
                try
                    if movie? and movie.title_popular? and movie.title_popular.length > 0 and movie.title_popular[0].title? and movie.title_popular[0].id?
                        imdbUrl = "www.imdb.com/title/#{movie.title_popular[0].id}"
                        msg.send "#{movie.title_popular[0].title} - #{imdbUrl}"
                    else
                        msg.send "That's not a movie, yo."
                catch error
                    robot.logger.error "IMDB error stacktrace =", error.stack
                    msg.send "There was an error fetching movie info."
