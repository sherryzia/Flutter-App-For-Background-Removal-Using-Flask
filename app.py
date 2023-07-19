from flask import Flask, request, jsonify, send_file
import os
from rembg import remove
from PIL import Image
from natsort import natsorted
import shutil

app = Flask(__name__)

@app.route('/')
def index():
    return '''
        <!DOCTYPE html>
        <html>
        <head>
            <title>Image Processing Form</title>
        </head>
        <body>
            <h1>Image Processing Form</h1>
            <form id="imageForm">
                <label for="inputDir">Input Directory Path:</label>
                <input type="text" id="inputDir" name="inputDir" required>
                <button type="submit">Process Images</button>
            </form>
            <p id="status"></p>

            <script>
                const form = document.getElementById('imageForm');
                const status = document.getElementById('status');

                form.addEventListener('submit', (e) => {
                    e.preventDefault();
                    const inputDir = document.getElementById('inputDir').value;
                    const data = { input_dir: inputDir };

                    fetch('/process_images', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                        },
                        body: JSON.stringify(data),
                    })
                    .then(response => response.json())
                    .then(result => {
                        status.textContent = result.message;
                    })
                    .catch(error => {
                        status.textContent = 'Error occurred during image processing.';
                    });
                });
            </script>
        </body>
        </html>
    '''

@app.route('/process_images', methods=['POST'])
def process_images():
    data = request.get_json()
    input_dir = data.get('input_dir', '')

    output_dir = 'output'
    os.makedirs(output_dir, exist_ok=True)

    files = natsorted(os.listdir(input_dir))

    for filename in files:
        if filename.endswith('.png') or filename.endswith('.jpg'):
            input_path = os.path.join(input_dir, filename)
            output_path = os.path.join(output_dir, str(filename.split('.')[0]) + '.png')

            input_image = Image.open(input_path)
            output_image = remove(input_image)
            output_image.save(output_path)

            input_image.close()
            output_image.close()

    return jsonify({'message': 'Image processing completed successfully.'})

@app.route('/download_images')
def download_images():
    shutil.make_archive('processed_images', 'zip', 'output')
    return send_file('processed_images.zip', as_attachment=True)

if __name__ == '__main__':
    app.run(debug=True)
