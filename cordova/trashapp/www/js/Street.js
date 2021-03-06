// Generated by CoffeeScript 1.6.3
(function() {
  window.Street = Backbone.Model.extend({
    defaults: {
      street: void 0,
      code: void 0,
      sector: void 0,
      provider: void 0,
      zip: void 0,
      place: void 0
    },
    initialize: function() {},
    parse: function(response, options) {
      var attributes;
      return attributes = {
        street: response.straatnaam,
        code: response.straatcode,
        sector: response.sector,
        provider: "ivago",
        zip: response.postcode,
        place: response.gemeente
      };
    }
  });

  window.IvagoStreetCollection = Backbone.Collection.extend({
    url: "data/ivago/stratenlijst.json",
    initialize: function() {
      var _this = this;
      this.fetch();
      return this.on('sync', function() {
        return "ivago streets synced";
      });
    },
    parse: function(response, options) {
      var results,
        _this = this;
      results = [];
      response["IVAGO-Stratenlijst"].forEach(function(element) {
        return results.push(Street.prototype.parse(element));
      });
      return results;
    }
  });

  window.StreetManager = Backbone.Model.extend({
    initialize: function() {
      this.streets = new IvagoStreetCollection;
      return this.pickups = new PickupCollection;
    },
    findStreetsWith: function(query, zip) {
      var results, streets,
        _this = this;
      if (zip) {
        streets = this.streets.where({
          zip: zip
        });
      } else {
        streets = this.streets;
      }
      results = streets.filter(function(element) {
        return element.get('street').toLowerCase().indexOf(query.toLowerCase()) !== -1;
      });
      return results;
    },
    getPickupsForSector: function(sector) {
      return this.pickups.where({
        sector: sector
      });
    }
  });

}).call(this);
