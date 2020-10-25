const likeDog = async dogLike => {
  let id = dogLike.id;
  let data = {
    dog: {
      id: id
    }
  }
  let response = await fetch(`like_dog`, { 
    method: "POST",
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(data)
  });
  if(response.ok){
    dogLike.innerHTML = "&#9829";
    dogLike.disabled = true;
    let numLikes = document.getElementById(`num-likes${id}`);
    let numLikesVal = parseInt(numLikes.innerHTML);
    numLikes.innerHTML = numLikesVal + 1;
  }
  else {
    alert("HTTP-Error: " + response.status);
  }
}

document.addEventListener("DOMContentLoaded", () => {
  let likeButtons = document.getElementsByClassName("like");
  for(let i = 0; i < likeButtons.length; i++){
    likeButtons[i].addEventListener("click", (e) =>{
      likeDog(e.target)
    });
  }
});