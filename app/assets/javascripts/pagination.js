const goToPage = page => {
  if(typeof page === "string"){
    page = page.trim()
  }
  let queryString = window.location.search;
  let params = queryString.includes("?likes=desc_last_hour") ? "?likes=desc_last_hour&page=" + page : "?page=" + page;
  let newUrl = window.location.origin + window.location.pathname + params;
  window.location.href = newUrl;
  return false;
}

const whenPaginationReady = () => {
  let pageNavButtons = document.getElementsByClassName("page-nav-button");
  for(let i = 0; i < pageNavButtons.length; i++){
    pageNavButtons[i].addEventListener("click", (e) =>{
      goToPage(e.target.innerHTML)
    });

  }
  document.getElementById("back-arrow").addEventListener("click", () => {
    let page = document.getElementById("current-page").innerHTML;
    goToPage(parseInt(page) - 1);
  });
  document.getElementById("forward-arrow").addEventListener("click", () => {
    let page = document.getElementById("current-page").innerHTML;
    goToPage(parseInt(page) + 1);
  });

}

document.addEventListener("turbolinks:load", whenPaginationReady);