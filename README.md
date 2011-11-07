This test app provides a REST API (http://en.wikipedia.org/wiki/Representational_state_transfer) that lists tv shows and movies available for streaming from the Netflix website.

### REST API Endpoints

Retrieve shows for a single category: http://dstautberg-test-app.heroku.com/category/<category_name>
* Example: http://dstautberg-test-app.heroku.com/category/New%20Arrivals

Retrieve shows matching the given search text: http://dstautberg-test-app.heroku.com/search/<search_text>
* Example: http://localhost:4567/search/simpsons

Keep in mind that special characters in URL's must be encoded to be parsed properly (see http://en.wikipedia.org/wiki/Percent-encoding).

### Data Format

Both API endpoints return show data in JSON format (http://www.json.org) as an array of hashes in the following layout:

    [
      {
        "title":      "Futurama: Into the Wild Green Yonder",
        "link":       "http://www.netflix.com/Movie/Futurama-Into-the-Wild-Green-Yonder/70112371?trkid=772959",
        "image_link": "http://cdn-1.nflximg.com/us/boxshots/large/70112371.jpg"
      },
      {
        "title":      "Brief Interviews with Hideous Men",
        "link":       "http://www.netflix.com/Movie/Brief-Interviews-with-Hideous-Men/70060054?trkid=772959",
        "image_link": "http://cdn-4.nflximg.com/us/boxshots/large/70060054.jpg"
      }
    ]

The "title" field is the name of the tv show or movie, the "link" field is the URL you would use to go to Netflix and watch the show (a Netflix login is required), and the "image_link" field is an image of the front of the DVD box (usually).
