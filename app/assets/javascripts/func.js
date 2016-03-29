$(document).ready(function(){
  $('#recipient_email').change(function(){
    $.ajax({
        url: '/conversations/get_recipients',
        datatype: 'json',
        method: 'GET'
    }).success(function(data){
      $('.chosen-select').empty();
      var content = '';
      data.forEach(function(item, i, arr) {
          content = '<option>'+item["email"]+'</option>';
          $('.chosen-select').append(content);
      });
      $('.chosen-select').trigger("chosen:updated");
    });
  });
  $('#recipient_last_name').change(function(){
    $.ajax({
        url: '/conversations/get_recipients',
        datatype: 'json',
        method: 'GET'
    }).success(function(data){
      $('.chosen-select').empty();
      var content = '';
      data.forEach(function(item, i, arr) {
          content = '<option>'+item["last_name"]+'</option>';
          $('.chosen-select').append(content);
      });
      $('.chosen-select').trigger("chosen:updated");
    });
  });


  // $('input[type=radio][name=recipient]').change(function() {
  //   if (this.value == 'email') {
  //     alert("EMAIL");
  //   }
  //   else if (this.value == 'last_name') {
  //     alert("LAST_NAME");
  //   }

  //   // $.ajax({
  //   //     url: 'mycontr/get_users',
  //   //     method: 'GET',
  //   //     datatype: 'json'
  //   //   }).success(functio(data){

  //   //     $.each(data, function(value,key) {
  //   //       $("#id").append($("<option></option>")
  //   //          .attr("value", value).text(key));
  //   //     });

  //   //   })
  // });

  // // $("#2").change(function(){
  // //   alert("2234");
});



//render :json {data[email] }
