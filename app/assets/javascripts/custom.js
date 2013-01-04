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

function changeBackground(elementId) {
  var li = document.getElementById(elementId);
  li.setAttribute("class", "link-back-click");
  return false;
}
