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
    width: 100
  });
});
