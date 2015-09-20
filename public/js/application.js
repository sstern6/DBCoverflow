
$(document).ready(function() {

  $('.comment-list').on("click", 'li > .fa-thumbs-up',function(event){
    event.preventDefault();
    var comment_id = $(this).parent().attr("id");
    var url = "/comments/" + comment_id + '/vote'

    $.ajax({
      method: "POST",
      url: url,
      dataType: 'json'
    })
    .done(function(response){
      $('li#' + comment_id).children('.vote_count').html(response.votes);
    });
  });

  $('.question-vote').click(function(event){
    event.preventDefault();
    $(this).css("color", "green");
    var question_id = $(this).parent().attr("id");
    var url = "/questions/" + question_id + "/vote"

    $.ajax({
      method: "POST",
      url: url,
      dataType: 'json',
    })
    .done(function(response){
      console.log(response);
    })
  });

  $('#new_comment_form').submit(function(event){
    event.preventDefault();
    var url = $(this).attr('action');

    var questionId = $("input[name=question_id]").val();
    var content = tinyMCE.get('editor').getContent();

    console.log(questionId);
    console.log(content);

    $.ajax({
      method: "POST",
      url: url,
      dataType: "json",
      data: {question_id: questionId, content: content}
    })

    .fail(function(fail_message){
      alert("Please log in before making a comment!")
    })

    .done(function(response){
      $("textarea").val("");
      var new_comment = "<li id='"+response.id+"'>";
      new_comment += "<span class='vote_count'>0</span>";
      new_comment += "&nbsp;&nbsp;<i class='fa fa-thumbs-up fa-2x'></i>&nbsp;&nbsp;";
      new_comment += response.user;
      new_comment += "<p class='comment-content'>"+ response.content +"</p></li>";
      $(".comment-list").append(new_comment);
    });
  });


});
