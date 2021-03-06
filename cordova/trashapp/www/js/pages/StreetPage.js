// Generated by CoffeeScript 1.6.3
(function() {
  window.StreetPage = Page.extend({});

  window.StreetPageView = PageView.extend({
    className: "street page",
    template: Templates.street,
    contextForTemplate: function() {
      return app.toJSON();
    },
    pageSpecificRender: function() {
      var _this = this;
      _.bindAll(this);
      this.page_height = window.screenHeight;
      this.zip_field = this.$el.find('.zip-field');
      this.street_button = this.$el.find(".street-button");
      this.nr_field = this.$el.find('.nr-field');
      this.next = this.$el.find('.next');
      this.modal = this.$el.find('#street-search-modal');
      this.modal.css("-webkit-transform", "translate3d(0px," + this.page_height + "px,0px)");
      this.searchbox = this.modal.find('.searchbox input');
      this.searchbox.on('keyup', _.debounce(this.updateAutoComplete, 150));
      this.searchresults = this.modal.find('.results');
      this.street_button.on('keydown', function(event) {
        return event.preventDefault();
      });
      this.street_button.on('focus', function(event) {
        event.preventDefault();
        _this.street_button.blur();
        return _.delay(function() {
          _this.modal.show();
          _this.$el.scrollTop(0);
          return _.defer(function() {
            _this.modal.css("-webkit-transform", "translate3d(0px,0px,0px)");
            _this.modal.css("opacity", "1");
            _this.searchbox.focus();
            return _this.$el.scrollTop(0);
          });
        }, 0);
      });
      this.zip_field.on('change keyup', function(event) {
        return _this.updateEnabledFields();
      });
      this.street_button.on('change keyup', function(event) {
        return _this.updateEnabledFields();
      });
      this.nr_field.on('change keyup', function(event) {
        return _this.updateEnabledFields();
      });
      this.model.on('change:selectedStreet', function() {
        _this.updateEnabledFields();
        return _this.street_button.val(_this.model.get('selectedStreet').street);
      });
      this.model.set({
        selectedStreet: app.get('street')
      });
      this.next.on('click', function() {
        return _this.nextPage();
      });
      return this.updateEnabledFields();
    },
    updateAutoComplete: function() {
      var items, query, result, results, zip, _fn, _i, _len, _ref,
        _this = this;
      query = this.searchbox.val();
      console.log(query);
      this.searchresults.empty();
      if (query.length < 2) {
        return;
      }
      zip = ((_ref = this.zip_field.val()) != null ? _ref.length : void 0) === 4 ? this.zip_field.val() : void 0;
      console.log("zip", zip);
      results = app.streetManager.findStreetsWith(query, zip);
      if (results.length > 0) {
        items = [];
        _fn = function(result) {
          var item;
          item = $(Templates.street_result({
            street: result.get('street')
          }));
          item.on('click', function() {
            return _this.selectStreet(result);
          });
          return items.push(item);
        };
        for (_i = 0, _len = results.length; _i < _len; _i++) {
          result = results[_i];
          _fn(result);
        }
        return this.searchresults.append(items);
      } else {
        return this.searchresults.append(Templates.no_results({
          zip: zip
        }));
      }
    },
    selectStreet: function(street) {
      var _this = this;
      console.log("select " + (street.get('street')));
      this.model.set({
        selectedStreet: street.toJSON()
      });
      this.modal.css("-webkit-transform", "translate3d(0px," + this.page_height + "px,0px)");
      this.modal.css("opacity", "0");
      return _.delay(function() {
        _this.modal.hide();
        _this.searchbox.val('');
        return _this.updateAutoComplete();
      }, 400);
    },
    updateEnabledFields: function() {
      this.zip_field.removeAttr('disabled');
      this.zip_field.removeClass('disabled');
      if (this.zip_field.val()) {
        this.street_button.removeAttr('disabled');
        this.street_button.removeClass('disabled');
      } else {
        this.street_button.prop('disabled', 'disabled');
        this.street_button.addClass('disabled');
      }
      if (this.zip_field.val() && (this.model.get('selectedStreet') != null)) {
        this.nr_field.removeAttr('disabled');
        return this.nr_field.removeClass('disabled');
      } else {
        this.nr_field.prop('disabled', 'disabled');
        return this.nr_field.addClass('disabled');
      }
    },
    nextPage: function() {
      var street;
      if ((this.model.get('selectedStreet') != null) && this.nr_field.val() !== "") {
        street = this.model.get('selectedStreet');
        street.nr = this.nr_field.val();
        app.set({
          street: street
        });
        return app.navigate('reminder');
      } else {
        return console.error("form not filled in");
      }
    }
  });

}).call(this);
