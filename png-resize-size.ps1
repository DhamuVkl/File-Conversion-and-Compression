# Check if ImageMagick is installed
$magickExecutable = Get-Command magick.exe -ErrorAction SilentlyContinue
if (-not $magickExecutable) {
    Write-Host "ImageMagick is not installed or not properly configured in the system PATH."
    exit
}

# Function to resize and compress PNG files using ImageMagick
function Resize-Compress-PNG {
    param (
        [string]$PNGFilePath,
        [int]$DesiredSizeKB,
        [int]$Quality = 80  # Set default quality to 80 (adjust as needed)
    )

    try {
        # Remove leading and trailing whitespace and quotation marks from the file path
        $PNGFilePath = $PNGFilePath.Trim('"')

        # Check if PNG file exists
        if (-not (Test-Path $PNGFilePath -PathType Leaf)) {
            Write-Host "PNG file not found: $PNGFilePath"
            return
        }

        # Extract the file name (without extension) from the input PNG file path
        $PNGFileNameWithoutExtension = [System.IO.Path]::GetFileNameWithoutExtension($PNGFilePath)

        # Get the output directory path
        $OutputPath = [System.IO.Path]::GetDirectoryName($PNGFilePath)

        # Use ImageMagick's identify command to get image information
        $imageInfo = & $magickExecutable identify -format "%w %h" "$PNGFilePath"
        $originalWidth, $originalHeight = $imageInfo -split ' '

        # Calculate the desired width based on the desired file size
        $originalSizeKB = (Get-Item $PNGFilePath).Length / 1KB
        $newSizeBytes = $DesiredSizeKB * 1024
        $scaleFactor = [math]::Sqrt($newSizeBytes / $originalSizeKB)
        $newWidth = [math]::Round($originalWidth * $scaleFactor)

        # Check if the dimensions exceed the limit
        if ($newWidth -gt 16383) {
            Write-Host "Resizing limit exceeded. Resizing image proportionally..."
            $newWidth = 16383  # Set the maximum width
            $scaleFactor = $newWidth / $originalWidth
        }

        # Use ImageMagick to resize and compress the PNG file
        $outputFile = & $magickExecutable convert "$PNGFilePath" -resize $newWidth -quality $Quality "$OutputPath\$PNGFileNameWithoutExtension-resized.png"

        Write-Host "Resize and compression completed. PNG file saved to: $OutputPath\$PNGFileNameWithoutExtension-resized.png"
    } catch {
        Write-Host "An error occurred: $_"
    }
}

# Prompt user for input
$PNGFilePath = Read-Host "Enter the full path of the PNG file:"
$DesiredSizeKB = Read-Host "Enter the desired size of the output file (in KB):"

# Call the function to resize and compress the PNG file
Resize-Compress-PNG -PNGFilePath $PNGFilePath -DesiredSizeKB $DesiredSizeKB

# Pause at the end of the script to see any error messages
Pause
