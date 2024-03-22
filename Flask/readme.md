# Background Removal Flask Server

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

## Contributing

Contributions are welcome! If you have suggestions or feature requests, please open an issue or submit a pull request.
