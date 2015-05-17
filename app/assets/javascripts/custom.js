$(document).ready(function() {
  $(function () {
    if($("#subject_species").val() == "project"){
      $(".normal_option").hide('fast');
    }else{
      $(".normal_option").show('fast');
    }
    $("#subject_species").change(function(){
      if($("#subject_species").val() == "project"){
        $(".normal_option").hide('fast');
      }else{
        $(".normal_option").show('fast');
      }
    });
  });
  $('.select-subjects').select2({
    width: "100%"
  });
  $('.select-one').select2({
    width: "100%"
  });
  $('.number-chosse').select2({
    width: "20%"
  });
  setTimeout(function() {
    $('.hide-flash-messages').fadeOut('normal');
  }, 3000);
});

function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $(link).parent().before(content.replace(regexp, new_id));
}