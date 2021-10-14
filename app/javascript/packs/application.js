// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")
require('jquery')
require('src/image-change.js')
require('src/slick.js')
require('src/preview-text.js');
require('src/fade-in-words.js');
require('src/font-change.js');

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
const images = require.context('../images', true)
const imagePath = (name) => images(name, true)

//= require jquery/dist/jquery.js
//= require popper.js/dist/popper.js
//= require bootstrap/dist/js/bootstrap.js
// = require_tree .
import '../stylesheets/application.scss';
import '@fortawesome/fontawesome-free/js/all';