// Generated by CoffeeScript 1.6.3
(function() {
  window.App = Backbone.Model.extend({
    defaults: {
      startup_hash: void 0,
      street: {},
      reminder: {}
    },
    initialize: function() {
      var _this = this;
      _.bindAll(this);
      Fixes.IEConsole();
      this.generateDeviceId();
      Fixes.detectPlatform();
      if (config.platform === 'wp' || config.platform === 'android2') {
        config.fixed_header = false;
      } else {
        config.fixed_header = true;
      }
      this.onResize();
      $(window).on("resize", this.onResize);
      $(window).on('orientationchange', this.onRotate);
      Fixes.backboneSuper();
      Fixes.fastClick();
      Fixes.preventWindowMovement();
      this.set({
        startup_hash: location.hash.substr(config.hash_characters.length)
      });
      this.startup();
      return _.defer(function() {
        _this.router = new Router();
        Backbone.history.start();
        _this.streetManager = new StreetManager;
        _this.pageManager = new PageManager({
          router: _this.router
        });
        _this.pageManagerView = new PageManagerView({
          model: _this.pageManager,
          el: document.getElementById("pageManager")
        });
        _this.pageManagerView.render();
        return _this.openFirstPage();
      });
    },
    openFirstPage: function() {
      var last_position, startup_hash, uri,
        _this = this;
      last_position = Cache.readFromLocalStorage("last_position");
      startup_hash = this.get('startup_hash');
      if (startup_hash) {
        uri = startup_hash;
      } else {
        if (last_position !== false) {
          console.log("restored your last position");
          uri = last_position;
        } else {
          uri = config.uri.intro.step1;
        }
      }
      return _.defer(function() {
        return _this.navigate(uri);
      });
    },
    navigate: function(uri) {
      return this.router.navigate(uri, {
        trigger: true
      });
    },
    onResize: function() {
      window.screenWidth = $(document).width();
      window.screenHeight = document.innerHeight ? document.innerHeight : $(document).height();
      return Fixes.adjustHeightToIPhoneStatusBar();
    },
    onRotate: function() {
      return this.repaint();
    },
    generateDeviceId: function() {
      var device_id, error;
      device_id = localStorage["device-id"];
      if (!device_id) {
        device_id = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
          var r, v;
          r = Math.random() * 16 | 0;
          v = c === 'x' ? r : r & 0x3 | 0x8;
          return v.toString(16);
        });
        console.log("created new device-id", device_id);
        try {
          localStorage.setItem("device-id", device_id);
        } catch (_error) {
          error = _error;
          console.warn("localStorage not available", error);
        }
      }
      return config.device_id = device_id;
    },
    startup: function() {
      var startupPage, uri;
      uri = config.uri.intro.step1;
      document.location.hash = "";
      startupPage = uri;
      return config.pages = [startupPage];
    },
    repaint: function() {
      this.onResize();
      return this.get('pageManagerView').render();
    }
  });

  if (window.device) {
    $(document).on('deviceready', function() {
      return window.app = new App();
    });
  } else {
    $(function() {
      return window.app = new App();
    });
  }

}).call(this);