// Generated by CoffeeScript 1.6.3
(function() {
  window.Cache = (function() {
    var clear, generateHash, public_functions, readFromLocalStorage, storeInLocalStorage;
    readFromLocalStorage = function(id) {
      var error, value;
      try {
        value = localStorage[id];
        if (value == null) {
          return false;
        }
        return value;
      } catch (_error) {
        error = _error;
        console.warn("localStorage not available", error);
        return false;
      }
    };
    storeInLocalStorage = function(id, data) {
      var error;
      try {
        return localStorage.setItem(id, data);
      } catch (_error) {
        error = _error;
        return console.warn("localStorage not available", error);
      }
    };
    generateHash = function(input) {
      var char, hash, i, _i, _ref;
      hash = 0;
      if (input.length === 0) {
        return hash;
      }
      for (i = _i = 0, _ref = input.length - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; i = 0 <= _ref ? ++_i : --_i) {
        char = input.charCodeAt(i);
        hash = ((hash << 5) - hash) + char;
        hash = hash & hash;
      }
      return hash + 2147483647;
    };
    clear = function() {
      var error, isCache, key, value;
      for (key in localStorage) {
        value = localStorage[key];
        isCache = (key.match(/^cache-/i)) != null;
        if (isCache) {
          localStorage.removeItem(key);
        }
      }
      try {
        return localStorage.removeItem("last_position");
      } catch (_error) {
        error = _error;
        return console.warn("localStorage not available", error);
      }
    };
    return public_functions = {
      storeInLocalStorage: storeInLocalStorage,
      readFromLocalStorage: readFromLocalStorage,
      clear: clear
    };
  })();

}).call(this);