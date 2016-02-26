// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require bootstrap
//= require bootstrap.min
//= require jquery.fancybox.js
//= require swipebox/js/jquery.swipebox.min.js
//= require api_help/prettyprint.js
//= require jquery.nicescroll.js
//= require jquery.scrollTo.min.js
//= require jquery.dcjqaccordion.2.7.js
//= require common-scripts.js

$( '.swipebox' ).swipebox();

var currentTarget = "";
var currentRaw    = "";
function example(name)
{
  currentTarget = $("#output_" + name);
  currentRaw    = $("#raw_" + name);
  currentTarget.html("..loading..");
  var link      = $("#example_" + name).val();
  var method    = $("#method_" + name).text();
  var data      = {};
  if($('.form_'+name).length){
    data = $('.form_'+name).serialize();
  };
  console.log(data);
  var link = $("#link_" + name).html();
  $.ajax({
    type:       method,
    url:        link,
    data:       data,
    processData: true,
    error: function(xhr, ajaxOptions, thrownError) {
      currentTarget.text("Error " + xhr.status + " " + xhr.responseText);
    }
  }).done(function(output){
    console.log("Output = ", output);
    if (typeof(output) == "object")
    {
      var txt = "Received JSON Object:\n<br/>";
      txt = prettyPrint(output);
      currentTarget.html(txt);
     } else {
       currentTarget.text("Raw output: " + output);
     }
  })
}

function exampleWithFile(name)
{
  currentTarget = $("#output_" + name);
  currentRaw = $("#raw_" + name);
  currentRaw.html("..loading..");
  currentTarget.html("..loading..");
  var link = $("#example_" + name).val();
  var method = $("#method_" + name).text();

  $.ajax({
    type:   method,
    url:    link,
    processData: false
  }).done(function(output){
    console.log("Output = ", output);
    if (typeof(output) == "object")
      {
         var txt = "Received JSON Object:\n<br/>";
         txt = prettyPrint(output);
         currentTarget.html(txt);
      } else {
        currentTarget.text("Raw output: " + output);
      }
    }).fail(function(obj, output)
    {
      currentTarget.text("FAILED: " + output);
    });
}

$(function() {
  $("#new_contact").on("submit", function() {
    var contactPhone = $('#contact_phone');
    var contactEmail = $('#contact_email');
    var contactMessage = $('#contact_message');

    if (contactPhone.val() === "" || /[0-9+()' '-]+/.test(contactPhone.val()) === false) {
      alert("Please enter a valid phone number");
    } else if (contactEmail.val() === "") {
      alert("Please enter an email address");
    } else if (contactMessage.val() === "") {
      alert("Please enter a contact message");
    } else {
      alert("Your message has been sent.");
      setTimeout(function() {
        contactPhone.val('');
        contactEmail.val('');
        contactMessage.val('');
      }, 100);
      return true;
    }
    return false;
  });

  $("#pro-person").click(function() {
    $(this).parent().find(".profile_border").removeClass('profile_border');
    $(this).addClass('profile_border');
    $("#profile_person").show();
    $("#profile_account").hide();
    $("#profile_notification").hide();

    $(this).addClass('active');
    $(this).siblings().each(function(){
       $(this).removeClass('active');
    });
  });

  $("#pro-acc").click(function() {
    $(this).parent().find(".profile_border").removeClass('profile_border');
    $(this).addClass('profile_border');
    $("#profile_person").hide();
    $("#profile_account").show();
    $("#profile_notification").hide();
      $(this).addClass('active');
      $(this).siblings().each(function(){
          $(this).removeClass('active');
      });
  });

  $("#pro-noti").click(function() {
    $(this).parent().find(".profile_border").removeClass('profile_border');
    $(this).addClass('profile_border');
    $("#profile_person").hide();
    $("#profile_account").hide();
    $("#profile_notification").show();
      $(this).addClass('active');
      $(this).siblings().each(function(){
          $(this).removeClass('active');
      });
  });

  $("#domestic").change(function(){
      $('.international_locations').hide().prop('disabled', true);
      $('.domestic_locations').show().prop('disabled', false);
  });

  $("#international").change(function(){
      $('.domestic_locations').hide().prop('disabled', true);
      $('.international_locations').show().prop('disabled', false);
  });

  $('.sidebar-toggle-box .fa-bars').click(function(){
     $('#nav-accordion').removeClass('expanded-sidebar-menu');
  });

});
