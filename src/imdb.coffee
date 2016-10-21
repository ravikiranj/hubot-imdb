#
# Description:
#   Get the movie poster and synposis for a given query
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot (imdb|movie) <movie>
#
# Author:
#   orderedlist, ravikiranj

module.exports = (robot) ->
  robot.respond /(imdb|movie)( me)? (.*)/i, (msg) ->
    query = msg.match[3]
    msg.http("http://omdbapi.com/")
      .query({
        t: query
      })
      .get() (err, res, body) ->
        movie = JSON.parse(body)
        if movie? and movie.Response? and movie.Response == "True"
          imdbUrl = "www.imdb.com/title/#{movie.imdbID}"
          text = "#{movie.Title} (#{movie.Year}) - #{imdbUrl}, Rating: #{movie.imdbRating}\n"
          text += "Info: #{movie.Plot}"
          msg.send text
          if movie.Poster?
              posterImage = "#{movie.Poster}\n"
              msg.send posterImage
        else
          msg.send "That's not a movie, yo."
