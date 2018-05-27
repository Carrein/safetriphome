/* A unit denotes all data encapsulated in a post when retrieving or storing from the database */
class Unit {
  var _content;
  var _id;
  var _time;

  Unit(this._content, this._id, this._time);

  //unit should be immutable, no setters.
  get content => _content;
  get id => _id;
  get time => _time;
}
