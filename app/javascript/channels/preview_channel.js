import consumer from "channels/consumer"

consumer.subscriptions.create("PreviewChannel", {
  connected() {
    console.log("connection established")
  },

  disconnected() {
    console.log("connection disconnected")
  },

  received(data) {
    document.getElementById("url_form").reset();
    let parentElement = document.getElementById("card_container");
    let status_element = document.getElementById("card_status");
    let existingImageHolder = document.getElementById("card_image");    
    
    let statusElement = document.createElement("span");
    statusElement.id = "card_status";
    statusElement.style.cssText = "margin-bottom: 2px; background-color: cadetblue; display: block; width: fit-content;"
    statusElement.classList.add("badge", "badge-pill", "badge-info")
    statusElement.innerText = data.status
    
    if (status_element) {
      parentElement.replaceChild(statusElement, status_element);
    } else {
      parentElement.appendChild(statusElement);
    }

    let image_url = data.image_url;
    let imagePlaceHolder;
    if(data.status == 'processed') {
      imagePlaceHolder = document.createElement('img');
      imagePlaceHolder.id = "card_image";
      imagePlaceHolder.src = image_url;
      imagePlaceHolder.classList.add('img-fluid');
      imagePlaceHolder.style.cssText = "max-width: 100%; max-height:100%; object-fit: contain"
    } else {
      imagePlaceHolder = document.createElement("div");
      imagePlaceHolder.id = "card_image";
      imagePlaceHolder.classList.add("spinner-border", "text-secondary");
    }
    
    
    
    if (existingImageHolder) {
      parentElement.replaceChild(imagePlaceHolder, existingImageHolder);
    } else {
      parentElement.appendChild(imagePlaceHolder);
    }
}
});
