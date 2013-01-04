function reply(commentId, userName) {
  reply_body = $("#comment_content");
  new_text = "@" + userName + " ";
  $("#comment_parent_id").val(commentId);
  if (reply_body.val().trim().length == 0)
    new_text += '';
  else
    new_text = "\n" + new_text;
    reply_body.focus().val(reply_body.val() + new_text);
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
