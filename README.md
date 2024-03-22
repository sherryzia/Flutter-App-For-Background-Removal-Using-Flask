# THIS REPOSITORY CONTAINS TWO SEPERATE APPS:

# Background Removal App (FLUTTER)

This Flutter application allows users to perform background removal on a batch of images. Users can select a directory containing images, and the app will send each image to a Flask server for processing. The processed images are then saved back to the original directory, overwriting the input images.

## Features

- Select a directory containing images for background removal.
- Send images to a Flask server for processing.
- Overwrite input images with processed images.
- Track the processing progress with a loading indicator.

## Usage

1. Open the application.
2. View the selected directory containing images for background removal.
3. Tap the "Process Images" button to start the background removal process.
4. Wait for the processing to complete. The loading indicator will be displayed during processing.
5. Once processing is finished, the input images will be overwritten with the processed images.

## Dependencies

- `file_picker`: For selecting directories containing images.
- `http`: For sending HTTP requests to the Flask server for image processing.

## License

This project is licensed under the [MIT License](LICENSE).

---

# Background Removal Flask Server (PYTHON & FLASK)

This Flask server provides an endpoint for processing images and removing their backgrounds using the rembg library. The processed images are returned to the client.

## Features

- Provides a `/process_images` endpoint for background removal.
- Accepts image files via HTTP POST requests.
- Removes the background from input images and returns processed images.
- Uses the rembg library for background removal.

## Usage

1. Run the Flask server using the provided Python script.
2. Send a POST request to the `/process_images` endpoint with an image file attached.
3. Receive the processed image as the response.

## Dependencies

- `Flask`: For building the web server.
- `rembg`: For background removal from images.
- `Pillow`: For image processing.
