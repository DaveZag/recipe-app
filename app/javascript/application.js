// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";

let openPopup = document.querySelector(".open-btn");
openPopup.addEventListener("click", () => {
  let popup = document.querySelector(".popup");
  let hidden = true;
  if (popup.classList.contains("hidden")) {
    popup.classList.remove("hidden");
  }
});

let closePopup = document.querySelector(".close-btn");
closePopup.addEventListener("click", () => {
  let popup = document.querySelector(".popup");
  if (!popup.classList.contains("hidden")) {
    popup.classList.add("hidden");
  }
});
