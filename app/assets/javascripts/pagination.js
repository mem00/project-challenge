const getNewUrl = (queryString, page) => {
  let params = queryString.includes("?likes=desc_last_hour") ? "?likes=desc_last_hour&page=" + page : "?page=" + page;
  let newUrl = window.location.origin + window.location.pathname + params;
  return newUrl;
}

const goToPage = page => {
  if(typeof page === "string"){
    page = page.trim()
  }
  let queryString = window.location.search;
  window.location.href = getNewUrl(queryString, page);
  return false;
}

const whenPaginationReady = () => {
  //replace url if params don't match page
  let queryString = window.location.search;
  let startOfPageNum = queryString.indexOf("page=") + "page=".length;
  if(startOfPageNum > -1){
    let pageNumSubstring = queryString.slice(startOfPageNum, startOfPageNum+1)
    let page = document.getElementById("current-page").innerHTML
    if(page !== pageNumSubstring){
      history.pushState({}, null, getNewUrl(queryString, page));
    }
  }

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