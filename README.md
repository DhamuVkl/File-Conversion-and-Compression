# PDF to PNG Converter with Size Compression

## Description
This set of PowerShell scripts enables the conversion of PDF files to PNG format while also offering the option to resize and compress the resulting PNG images to meet a desired output file size. The scripts utilize ImageMagick to perform the conversion, resizing, and compression operations. Users can convert PDF files to PNG format and optionally compress the size of the resulting images to optimize file storage and transfer.

## Installation Instructions
1. **Install ImageMagick:**
   - Download and install ImageMagick from the official website: [ImageMagick](https://imagemagick.org/script/download.php).
   - During installation, ensure to select the option to add ImageMagick to the system PATH for command-line access.

2. **Install Ghostscript:**
   - Download and install Ghostscript from the official website: [Ghostscript](https://www.ghostscript.com/download/gsdnld.html).
   - During installation, make sure to select the option to add Ghostscript to the system PATH to enable command-line access.


3. **Clone or Download the Scripts:**
   - Clone this repository or download the script files (`pdf-to-png.ps1` and `png-resize-size.ps1`) to your local machine.

## Usage Instructions
1. **Convert PDF to PNG:**
   - Open PowerShell.
   - Navigate to the directory where the script (`pdf-to-png.ps1`) is located.
   - Run the script by executing the command `.\pdf-to-png.ps1`.
   - Follow the prompts to enter the full path of the PDF file you want to convert. The resulting PNG files will be saved in the "Exported" folder within the Downloads directory.

2. **Resize and Compress PNG File:**
   - Open PowerShell.
   - Navigate to the directory where the script (`png-resize-pixel.ps1`) is located.
   - Run the script by executing the command `.\png-resize-pixel.ps1`.
   - Follow the prompts to enter the full path of the PNG file you want to resize and compress, as well as the desired size of the output file in kilobytes.

## Notes
- Ensure that ImageMagick is properly installed and configured in the system PATH before running the scripts.
- Provide the full path of the input files when prompted, including the file extension.
- The output files will be saved in the same directory as the input files, with the suffix "-resized" for the resized PNG files and in the "Exported" folder for the converted PNG files.
