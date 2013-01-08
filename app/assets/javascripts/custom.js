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

$(function() {

  $("#all").live('ajax:beforeSend', function(event, xhr, settings) {
    var state = {
      action: 'all',
      url: '/activities'
    };
    if(history && history.pushState) {
      history.pushState(state, document.title, '/activities');
    }
  });

  $("#past").live('ajax:beforeSend', function(event, xhr, settings) {
    var state = {
      action: 'past',
      url: '/activities/past'
    };
    if(history && history.pushState) {
      history.pushState(state, document.title, '/activities/past');
    }
  });

  $("#upcoming").live('ajax:beforeSend', function(event, xhr, settings) {
    var state = {
      action: 'upcoming',
      url: '/activities/upcoming'
    };
    if(history && history.pushState) {
      history.pushState(state, document.title, '/activities/upcoming');
    }
  });

  $("#active").live('ajax:beforeSend', function(event, xhr, settings) {
    var state = {
      action: 'active',
      url: '/activities/active'
    };
    if(history && history.pushState) {
      history.pushState(state, document.title, '/activities/active');
    }
  });
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
  /*
  switch (e.state.action) {
    case 'all':
      break;
    case 'upcoming':
      break;
    case 'active':
      break;
    case 'past':
      break;
  }
  */
  if (e.state == null) {
    var li = document.getElementById('all');
    li.className += " " + "link-back-click";
  } else {
    var li = document.getElementById(e.state.action);
    li.className += " " + "link-back-click";
  }
  return false;
}
