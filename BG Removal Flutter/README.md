# Background Removal App

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

## Contributing

Contributions are welcome! If you have suggestions or feature requests, please open an issue or submit a pull request.
