# Check if ImageMagick is installed
$magickExecutable = Get-Command magick.exe -ErrorAction SilentlyContinue
if (-not $magickExecutable) {
    Write-Host "ImageMagick is not installed or not properly configured in the system PATH."
    exit
}

# Function to convert PDF to PNG using ImageMagick
function Convert-PDFtoPNG {
    param (
        [string]$PDFFilePath,
        [string]$OutputPath
    )

    try {
        # Remove leading and trailing whitespace and quotation marks from the file path
        $PDFFilePath = $PDFFilePath.Trim('"')

        # Check if PDF file exists
        if (-not (Test-Path $PDFFilePath -PathType Leaf)) {
            Write-Host "PDF file not found: $PDFFilePath"
            return
        }

        # Extract the file name (without extension) from the input PDF file path
        $PDFFileNameWithoutExtension = [System.IO.Path]::GetFileNameWithoutExtension($PDFFilePath)

        # Create output directory if it doesn't exist
        if (-not (Test-Path $OutputPath -PathType Container)) {
            New-Item -Path $OutputPath -ItemType Directory -Force | Out-Null
        }

        # Use ImageMagick to convert PDF to PNG with the same name as input PDF
        $outputFiles = & $magickExecutable convert -density 300 -quality 100 -antialias "$PDFFilePath" "$OutputPath\$PDFFileNameWithoutExtension.png"

        Write-Host "Conversion completed. PNG file saved to: $OutputPath\$PDFFileNameWithoutExtension.png"
    } catch {
        Write-Host "An error occurred: $_"
    }
}

# Prompt user for input
$PDFFilePath = Read-Host "Enter the full path of the PDF file:"

# Get the Documents folder path
$DocumentsPath = [System.Environment]::GetFolderPath('MyDocuments')

# Set the output path to Documents\Exported
$OutputPath = Join-Path -Path $DocumentsPath -ChildPath "Exported"

# Call the function to convert PDF to PNG
Convert-PDFtoPNG -PDFFilePath $PDFFilePath -OutputPath $OutputPath

# Pause at the end of the script to see any error messages
Pause
