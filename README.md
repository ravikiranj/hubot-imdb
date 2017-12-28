# hubot-imdb

fetches imdb details about a movie

See [`src/imdb.coffee`](src/imdb.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install hubot-imdb --save`

Then add **hubot-imdb** to your `external-scripts.json`:

```json
[
  "hubot-imdb"
]
```

## Configuration
* Obtain an OMDB API Key via http://www.omdbapi.com/apikey.aspx and set `HUBOT_OMDB_API_KEY` variable in your config.

```
export HUBOT_OMDB_API_KEY="YOUR_API_KEY"
```

## Sample Interaction

```
user1>> hubot movie spirited away
hubot>> Spirited Away (2001) - www.imdb.com/title/tt0245429
https://images-na.ssl-images-amazon.com/images/M/MV5BMzliMzYxOWEtMDQxNy00OWI4LWI0ZDktOTU2YTdhZWMzMDdjXkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_SX300.jpg
```
