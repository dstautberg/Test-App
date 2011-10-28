This test app provides a REST API (http://en.wikipedia.org/wiki/Representational_state_transfer) that lists new shows available for streaming from the Netflix website.

The REST API is available at http://dstautberg-test-app.heroku.com/api, and returns a list of new shows in JSON format (http://www.json.org).  The data is an array of hashes in the following layout:

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