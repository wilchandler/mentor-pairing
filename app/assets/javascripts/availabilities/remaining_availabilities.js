function RemainingAvailabilityUpdater(selector, path, interval) {
  this.selector = selector;
  this.path = path;
  this.interval = interval;
}
RemainingAvailabilityUpdater.prototype.update = function (content) {
  $(this.selector).replaceWith(content);
}
RemainingAvailabilityUpdater.prototype.fetch = function () {
  return $.get(this.path).done(this.update.bind(this));
}
RemainingAvailabilityUpdater.prototype.start = function () {
  this.fetch();
  this.intervalId = setInterval(this.fetch.bind(this), this.interval);
}
RemainingAvailabilityUpdater.prototype.stop = function () {
  clearInterval(this.intervalId);
}
