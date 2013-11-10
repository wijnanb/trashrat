window.Templates = window.Templates || {};
window.Templates['data'] = function (__obj) {
  if (!__obj) __obj = {};
  var __out = [], __capture = function(callback) {
    var out = __out, result;
    __out = [];
    callback.call(this);
    result = __out.join('');
    __out = out;
    return __safe(result);
  }, __sanitize = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else if (typeof value !== 'undefined' && value != null) {
      return __escape(value);
    } else {
      return '';
    }
  }, __safe, __objSafe = __obj.safe, __escape = __obj.escape;
  __safe = __obj.safe = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else {
      if (!(typeof value !== 'undefined' && value != null)) value = '';
      var result = new String(value);
      result.ecoSafe = true;
      return result;
    }
  };
  if (!__escape) {
    __escape = __obj.escape = function(value) {
      return ('' + value)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;');
    };
  }
  (function() {
    (function() {
      __out.push('<div class="step">\n    <div class="inner">\n        user<br>\n        data\n    </div>\n</div>\n\n<h2 class="align-center">This is the data stored on your device.</h2>\n\n<div>\n    <p>zip: ');
    
      __out.push(__sanitize(this.street.zip));
    
      __out.push('</p>\n    <p>street: ');
    
      __out.push(__sanitize(this.street.street));
    
      __out.push('</p>\n    <p>nr: ');
    
      __out.push(__sanitize(this.street.nr));
    
      __out.push('</p>\n    <p>sector: ');
    
      __out.push(__sanitize(this.street.sector));
    
      __out.push('</p>\n    <p>day: ');
    
      __out.push(__sanitize(this.reminder.day));
    
      __out.push('</p>\n    <p>time: ');
    
      __out.push(__sanitize(this.reminder.time));
    
      __out.push('</p>\n</div>\n\n<button class="next pull-right" href="#street">start again</button>\n');
    
    }).call(this);
    
  }).call(__obj);
  __obj.safe = __objSafe, __obj.escape = __escape;
  return __out.join('');
};
window.Templates['no_results'] = function (__obj) {
  if (!__obj) __obj = {};
  var __out = [], __capture = function(callback) {
    var out = __out, result;
    __out = [];
    callback.call(this);
    result = __out.join('');
    __out = out;
    return __safe(result);
  }, __sanitize = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else if (typeof value !== 'undefined' && value != null) {
      return __escape(value);
    } else {
      return '';
    }
  }, __safe, __objSafe = __obj.safe, __escape = __obj.escape;
  __safe = __obj.safe = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else {
      if (!(typeof value !== 'undefined' && value != null)) value = '';
      var result = new String(value);
      result.ecoSafe = true;
      return result;
    }
  };
  if (!__escape) {
    __escape = __obj.escape = function(value) {
      return ('' + value)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;');
    };
  }
  (function() {
    (function() {
      __out.push('<div class="no-results">\n    Geen resultaten gevonden binnen postcode ');
    
      __out.push(__sanitize(this.zip));
    
      __out.push('. \n</div>');
    
    }).call(this);
    
  }).call(__obj);
  __obj.safe = __objSafe, __obj.escape = __escape;
  return __out.join('');
};
window.Templates['reminder'] = function (__obj) {
  if (!__obj) __obj = {};
  var __out = [], __capture = function(callback) {
    var out = __out, result;
    __out = [];
    callback.call(this);
    result = __out.join('');
    __out = out;
    return __safe(result);
  }, __sanitize = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else if (typeof value !== 'undefined' && value != null) {
      return __escape(value);
    } else {
      return '';
    }
  }, __safe, __objSafe = __obj.safe, __escape = __obj.escape;
  __safe = __obj.safe = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else {
      if (!(typeof value !== 'undefined' && value != null)) value = '';
      var result = new String(value);
      result.ecoSafe = true;
      return result;
    }
  };
  if (!__escape) {
    __escape = __obj.escape = function(value) {
      return ('' + value)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;');
    };
  }
  (function() {
    (function() {
      var _ref;
    
      __out.push('<div class="step">\n    <div class="inner">\n        stap<br>\n        2/2\n    </div>\n</div>\n\n<h2 class="align-center">Reminder instellen</h2>\n\n<div class="group">\n    <label>Dag:</label>\n    <div class="item ');
    
      if (this.reminder.day !== 'previous_day') {
        __out.push('selected');
      }
    
      __out.push(' option-0">\n        <div class="legend">Dag van ophaling</div>\n        <div class="checkbox"></div>\n    </div>\n\n    <div class="item ');
    
      if (this.reminder.day === 'previous_day') {
        __out.push('selected');
      }
    
      __out.push(' option-1">\n        <div class="legend">1 dag voor ophaling</div>\n        <div class="checkbox"></div>\n    </div>\n</div>\n\n<div class="group">\n    <label>Tijdstip:</label>\n    <div class="item selected">\n        <div class="legend time">&nbsp;\n            <input class="timepicker" type="time" value="');
    
      __out.push(__sanitize((_ref = this.reminder.time) != null ? _ref : '07:00:00'));
    
      __out.push('" />\n        </div>\n        \n        <div class="pencil"></div>\n    </div>\n</div>\n\n    <button class="next pull-right">Volgende</button>\n</form>');
    
    }).call(this);
    
  }).call(__obj);
  __obj.safe = __objSafe, __obj.escape = __escape;
  return __out.join('');
};
window.Templates['street'] = function (__obj) {
  if (!__obj) __obj = {};
  var __out = [], __capture = function(callback) {
    var out = __out, result;
    __out = [];
    callback.call(this);
    result = __out.join('');
    __out = out;
    return __safe(result);
  }, __sanitize = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else if (typeof value !== 'undefined' && value != null) {
      return __escape(value);
    } else {
      return '';
    }
  }, __safe, __objSafe = __obj.safe, __escape = __obj.escape;
  __safe = __obj.safe = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else {
      if (!(typeof value !== 'undefined' && value != null)) value = '';
      var result = new String(value);
      result.ecoSafe = true;
      return result;
    }
  };
  if (!__escape) {
    __escape = __obj.escape = function(value) {
      return ('' + value)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;');
    };
  }
  (function() {
    (function() {
      var _ref, _ref1, _ref2;
    
      __out.push('<div class="step">\n    <div class="inner">\n        stap<br>\n        1/2\n    </div>\n</div>\n\n<h2 class="align-center">Bepaal jouw ophaalzone</h2>\n\n<div>\n    <div>\n        <input type="text" class="zip-field" placeholder="Postcode" value="');
    
      __out.push(__sanitize((_ref = this.street.zip) != null ? _ref : ''));
    
      __out.push('" />\n    </div>\n\n    <div>\n        <input type="text" class="street-button" placeholder="Straat" value="');
    
      __out.push(__sanitize((_ref1 = this.street.street) != null ? _ref1 : ''));
    
      __out.push('" />\n    </div>\n\n    <div>\n        <input type="text" class="nr-field" placeholder="Nr" value="');
    
      __out.push(__sanitize((_ref2 = this.street.nr) != null ? _ref2 : ''));
    
      __out.push('" />\n    </div>\n</div>\n\n    <button class="next pull-right">Volgende</button>\n</form>\n\n<div id="street-search-modal" class="modal">\n    <div class="searchbox">\n        <input type="text" placeholder="Zoek je straat"/>\n    </div>\n    <div class="results"></div>\n</div>');
    
    }).call(this);
    
  }).call(__obj);
  __obj.safe = __objSafe, __obj.escape = __escape;
  return __out.join('');
};
window.Templates['street_result'] = function (__obj) {
  if (!__obj) __obj = {};
  var __out = [], __capture = function(callback) {
    var out = __out, result;
    __out = [];
    callback.call(this);
    result = __out.join('');
    __out = out;
    return __safe(result);
  }, __sanitize = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else if (typeof value !== 'undefined' && value != null) {
      return __escape(value);
    } else {
      return '';
    }
  }, __safe, __objSafe = __obj.safe, __escape = __obj.escape;
  __safe = __obj.safe = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else {
      if (!(typeof value !== 'undefined' && value != null)) value = '';
      var result = new String(value);
      result.ecoSafe = true;
      return result;
    }
  };
  if (!__escape) {
    __escape = __obj.escape = function(value) {
      return ('' + value)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;');
    };
  }
  (function() {
    (function() {
      __out.push('<div class="search-result">\n    ');
    
      __out.push(__sanitize(this.street));
    
      __out.push('\n</div>\n');
    
    }).call(this);
    
  }).call(__obj);
  __obj.safe = __objSafe, __obj.escape = __escape;
  return __out.join('');
};
window.Templates['stub'] = function (__obj) {
  if (!__obj) __obj = {};
  var __out = [], __capture = function(callback) {
    var out = __out, result;
    __out = [];
    callback.call(this);
    result = __out.join('');
    __out = out;
    return __safe(result);
  }, __sanitize = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else if (typeof value !== 'undefined' && value != null) {
      return __escape(value);
    } else {
      return '';
    }
  }, __safe, __objSafe = __obj.safe, __escape = __obj.escape;
  __safe = __obj.safe = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else {
      if (!(typeof value !== 'undefined' && value != null)) value = '';
      var result = new String(value);
      result.ecoSafe = true;
      return result;
    }
  };
  if (!__escape) {
    __escape = __obj.escape = function(value) {
      return ('' + value)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;');
    };
  }
  (function() {
    (function() {
      __out.push('<h2>');
    
      __out.push(__sanitize(this.uri));
    
      __out.push('</h2>\n<p>This is a stub for a page</p>');
    
    }).call(this);
    
  }).call(__obj);
  __obj.safe = __objSafe, __obj.escape = __escape;
  return __out.join('');
};
