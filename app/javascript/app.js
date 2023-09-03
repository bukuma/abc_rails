import { Turbo } from "@hotwired/turbo-rails"
Turbo.session.drive = false

// 画像プレビュー機能
document.addEventListener("turbo:load", function() {
  const imageUpload = document.getElementById('imageUpload');
  imageUpload.addEventListener('change', function() {
    const file = this.files[0];
    if (file) {
      const reader = new FileReader();
      const imagePreview = document.getElementById('imagePreview');
      const imagePreviewImage = imagePreview.querySelector('.image-preview__image');
      const imagePreviewDefaultText = imagePreview.querySelector('.image-preview__default-text');

      imagePreviewImage.style.display = "block";
      imagePreviewDefaultText.style.display = "none";

      reader.addEventListener("load", function() {
        imagePreviewImage.setAttribute("src", this.result);
      });

      reader.readAsDataURL(file);
    }
  });
});