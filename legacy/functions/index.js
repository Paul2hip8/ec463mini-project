const functions = require("firebase-functions");

const Botometer = require("node-botometer");

const B = new Botometer({
  consumer_key: "c5uB923Kxhmm4CbTN2H9xbd5w",
  consumer_secret: "ubA7OYSwgvsxjHsv9DRWHgY7Z466BWLS1fbEcuKSAd4JtAVKo2",
  access_token: "1568054324311343106-q5JIqaAInwtOAvfWDBrEb7xKgOE3s9",
  access_token_secret: "lUAZ0ua2ck8XiINxmkGjTbGtAFhWNhnW13lRjEU8ufPeJ",
  app_only_auth: true,
  mashape_key: "84024ab43bmsha3a872b3d68e5bdp1584e6jsn8d08ba92e9bf",
  rate_limit: 0,
  log_progress: true,
  include_user: true,
  include_timeline: true,
  include_mentions: true,
});

exports.webhook = functions.https.onRequest((req, res) => {
  const user = req.body;
  B.getBotScore(user, (err, data) => {
    if (err) {
      console.log(err);
      res.send(err);
    } else {
      console.log(data);
      res.send(data);
    }
  });
});
