// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.scss"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"





document.addEventListener('DOMContentLoaded', () => {
  // notification delete button
  (document.querySelectorAll('.notification .delete') || []).forEach(el => {
    el.addEventListener('click', event => {
      event.target.parentNode.parentNode.removeChild(event.target.parentNode)
    });
  });

  // Add a click event on each of "navbar-burger" elements
  (document.querySelectorAll('.navbar-burger') || []).forEach( el => {
    el.addEventListener('click', () => {
      // Toggle the "is-active" class on both the "navbar-burger" and the "navbar-menu"
      el.classList.toggle('is-active');
      // Get the target from the "data-target" attribute
      document.getElementById('topnav-menu').classList.toggle('is-active');
    });
  });

  // Add a click event on each of navbar dropdowns
  (document.querySelectorAll('.navbar-item.has-dropdown .navbar-link') || []).forEach( el => {
    el.addEventListener('click', () => {
      el.parentNode.classList.toggle('is-active');
    });
  });
});
