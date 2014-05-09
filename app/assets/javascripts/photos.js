// there will be resopnse with photos/create.js
$(document).ready(function(){
  $('#photo_uploaded_data').change(function(){                
    //array input
     var filedata = $('#photo_uploaded_data')[0],
       formdata = false;
       if (window.FormData) {
          formdata = new FormData();
       }
       var i = 0, len = filedata.files.length, img, reader, file;

       for (; i < len; i++) {
          //image
           file = filedata.files[i];

           if (window.FileReader) {
               reader = new FileReader();
               reader.onloadend = function(e) {
                  //showUploadedItem(e.target.result, file.fileName);
               };
               reader.readAsDataURL(file);
           }
           if (formdata) {
               formdata.append("file", file);
               $.ajax({
                 url: "#{photos_path()}?type=club",
                 type: "POST",
                 data: formdata,
                 processData: false,
                 contentType: false,
                 success: function(res) {

                 },
                 error: function(res) {

                  }
               });
           }
       }
    });
});