document.addEventListener("DOMContentLoaded", () => {

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

  function goToPage(page){
    if(typeof page === "string"){
      page = page.trim()
    }
    let newUrl = window.location.origin + window.location.pathname + "?page=" + page;
    window.location.href = newUrl;
    return false;
  }
});