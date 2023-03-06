// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")
import "bootstrap"

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

const $dropdown = $(".dropdown");
const $dropdownToggle = $(".dropdown-toggle");
const $dropdownMenu = $(".dropdown-menu");
const showClass = "show";

$(document).on('turbolinks:load', function() {
  $(".dropdown").on("mouseenter",
      function() {
        const $this = $(this);
        $this.addClass(showClass);
        $this.find($(".dropdown-toggle")).attr("aria-expanded", "true");
        $this.find($(".dropdown-menu")).addClass("show");
      }
    );
    $(".dropdown").on("mouseleave",
    function() {
      const $this = $(this);
      $this.removeClass(showClass);
      $this.find($(".dropdown-toggle")).attr("aria-expanded", "false");
      $this.find($(".dropdown-menu")).removeClass(showClass);
    }
  );
});