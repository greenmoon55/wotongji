function reply(commentId, userName) {
  reply_body = $("#comment_content");
  new_text = "@" + userName + " ";
  $("#comment_parent_id").val(commentId);
  reply_body.val(reply_body.val().replace(/^@\w+\s/, ""));
  reply_body.focus().val(new_text + reply_body.val());
  return false;
}

function highlightTime(elementId) {
  $(".activities-time.link-back-click").removeClass("link-back-click");
  $(".activities-category.link-back-click").removeClass("link-back-click");
  var li = document.getElementById(elementId);
  li.className += " " + "link-back-click";
  return false;
}

function highlightCategory(elementId) {
  $(".activities-category.link-back-click").removeClass("link-back-click");
  var li = document.getElementById(elementId);
  li.className += " " + "link-back-click";
  return false;
}

function getElementsByClassName(className) {
  var el = new Array();
  var _el = document.getElementsByTagName("*");
  for (var i=0; i<_el.length; i++ ) {
    if (_el[i].className == className) {
      el[el.length] = _el[i];
    }
  }
  return el;
}

$(function() {

  $(".activities-time").hover(function() {
    $(this).addClass("link-back-hover");
  }, function() {
    $(this).removeClass("link-back-hover");
  });

  $(".activities-category").hover(function() {
    $(this).addClass("link-back-hover");
  }, function() {
    $(this).removeClass("link-back-hover");
  });

  $("#all").live('ajax:beforeSend', function(event) {
    var state = {
      action: 'all',
      url: '/activities'
    };
    if(history && history.pushState) {
      history.pushState(state, document.title, '/activities');
    }
  });

  $("#past").live('ajax:beforeSend', function(event) {
    var state = {
      action: 'past',
      url: '/activities/past'
    };
    if(history && history.pushState) {
      history.pushState(state, document.title, '/activities/past');
    }
  });

  $("#upcoming").live('ajax:beforeSend', function(event) {
    var state = {
      action: 'upcoming',
      url: '/activities/upcoming'
    };
    if(history && history.pushState) {
      history.pushState(state, document.title, '/activities/upcoming');
    }
  });

  $("#active").live('ajax:beforeSend', function(event) {
    var state = {
      action: 'active',
      url: '/activities/active'
    };
    if(history && history.pushState) {
      history.pushState(state, document.title, '/activities/active');
    }
  });

  var categories = getElementsByClassName('activities-category');
  for (var i = 0; i < categories.length; i++) {
    $(categories[i]).live('ajax:beforeSend', function(event){
      var url = '/activities';
      var id = $(this).attr('id');
      var timeStr = '';
      var thisURL = window.location.href;
      if (thisURL.indexOf('upcoming') != -1) {
        timeStr = '/upcoming/category/';
      } else if (thisURL.indexOf('active') != -1) {
        timeStr = '/active/category/';
      } else if (thisURL.indexOf('past') != -1) {
        timeStr = '/past/category/';
      } else {
        timeStr = '/category/';
      }
      url += timeStr + id;
      var state = {
        action: id,
        url: url
      };
      if (history && history.pushState) {
        history.pushState(state, document.title, url);
      }
    });
  }
});

if(history && history.pushState) {
  var loaded = false;
  $(window).bind("popstate", function() {
    if (!loaded) {
      loaded = true;
    } else {
      $.getScript(location.href);
    }
  });
}

window.onpopstate = function(e) {
  $(".activities-time.link-back-click").removeClass("link-back-click");
  $(".activities-category.link-back-click").removeClass("link-back-click");

  if (e.state == null) {
    var li = document.getElementById('all');
    li.className += " " + "link-back-click";
  } else {
    var li = document.getElementById(e.state.action);
    li.className += " " + "link-back-click";
  }
  return false;
}
