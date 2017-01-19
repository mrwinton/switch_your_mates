document.addEventListener("DOMContentLoaded", function (event) {
    initImageHandling();
});

function initImageHandling() {

  for (var imageInput of document.getElementsByClassName('image-input')) {
    imageInput.addEventListener('change', function() {
      onChangeImageInput(this);
    });
  }

  var imageResultView = document.getElementById('result-image-view');
  var imageSave = document.getElementById('image-save');
  imageSave.addEventListener('click', onSaveImage);

  var reset = document.getElementById('reset');
  reset.addEventListener('click', onResetState);

  //events
  function onChangeImageInput(imageInput) {
    console.log("IMAGE CHANGE");
    var selectImageContainer = imageInput.closest('.select-image');
    var imageView = selectImageContainer.querySelector(".image-view");

    var image = imageInput.files[0];

    previewImage(image, imageView);
  };

  function onSaveImage(event) {
    console.log("IMAGE SAVE");
    event.preventDefault();

    var imageInputs = Array.prototype.slice.call(document.querySelectorAll('input[type=file]'));
    if(imageInputs.every(hasImageLoaded)) {
      var formElement = document.querySelector("form");
      var data = new FormData(formElement);

      loading();

      post(formElement.action, data, function(response) {
        //success callback
        imageResultView.src = response['image_path'];
        loaded();
      });
    } else {
      console.log("image(s) not loaded");
    }
  };

  function loading() {
    // hide form
    hideForm();
    // show loading
    showLoading();
  };

  function loaded() {
    // hide loading
    hideLoading();
    // show result
    showResult();
  };

  function onResetState() {
    // clear input and image in form
    clearImageInputValue();
    clearSelectImageSource();
    // hide result
    hideResult();
    // show form
    showForm();
  };

  //actions
  function hasImageLoaded(imageInput, index, array) {
    if(imageInput.files[0]){
      return true;
    } else {
      return false;
    }
  };

  function hideForm() {
    var formContainer = document.getElementById('form-container');
    formContainer.classList.add('hidden');
  };

  function showForm() {
    var formContainer = document.getElementById('form-container');
    formContainer.classList.remove('hidden');
  };

  function showLoading() {
    var loadingContainer = document.getElementById('loading-container');
    loadingContainer.classList.remove('hidden');
  };

  function hideLoading() {
    var loadingContainer = document.getElementById('loading-container');
    loadingContainer.classList.add('hidden');
  };

  function showResult() {
    var resultContainer = document.getElementById('result-container');
    resultContainer.classList.remove('hidden');
  };

  function hideResult() {
    var resultContainer = document.getElementById('result-container');
    resultContainer.classList.add('hidden');
  };

  function clearSelectImageSource() {
    for (var imageInput of document.getElementsByClassName('image-view')) {
      imageInput.src = '';
    }
  };

  function clearImageInputValue() {
    for (var imageInput of document.getElementsByClassName('image-input')) {
      imageInput.value = '';
    }
  };

  function previewImage(image, targetImageView) {
    console.log("IMAGE PREVIEW");

    var reader = new FileReader();

    reader.onloadend = function () {
      targetImageView.src = reader.result;
    };

    if (image) {
      reader.readAsDataURL(image);
    } else {
      targetImageView.src = "";
    }
  };

  function post(url, data, success){
    var request = new XMLHttpRequest();

    (request.upload || request).addEventListener('progress', function(e) {
      var done = e.position || e.loaded;
      var total = e.totalSize || e.total;
      console.log('xhr progress: ' + Math.round(done/total*100) + '%');
    });

    request.open('POST', url, true);

    request.onload = function() {
      if (request.status >= 200 && request.status < 400) {
        // Success!
        var data = JSON.parse(request.responseText);
        success(data);
      } else {
        console.log('reached our target server, but it returned an error');
      }
    };

    request.onerror = function() {
      console.log('there was an error of some sort');
    };

    request.send(data);
  };
};
