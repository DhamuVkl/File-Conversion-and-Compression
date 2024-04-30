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
        [int]$NewWidth = 1080,
        [int]$Quality  
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

        # Use ImageMagick to resize and compress the PNG file
        $outputFile = & $magickExecutable convert "$PNGFilePath" -resize $NewWidth -quality $Quality "$OutputPath\$PNGFileNameWithoutExtension-resized.png"

        Write-Host "Resize and compression completed. PNG file saved to: $OutputPath\$PNGFileNameWithoutExtension-resized.png"
    }
    catch {
        Write-Host "An error occurred: $_"
    }
}

# Prompt user for input
$PNGFilePath = Read-Host "Enter the full path of the PNG file:"
$Quality = Read-Host "Enter the desired Quality for the PNG (in 0-100):"

# Call the function to resize and compress the PNG file
Resize-Compress-PNG -PNGFilePath $PNGFilePath -quality $Quality

# Pause at the end of the script to see any error messages
Pause
